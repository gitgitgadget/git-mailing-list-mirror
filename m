From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/11] refs: move REF_DELETING to refs.c
Date: Mon, 9 Feb 2015 10:09:01 -0800
Message-ID: <CAGZ79kb1xYBCGALM99f2L1pVKYyrpstDfgaVneHmW25=9_ZVhA@mail.gmail.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<1423412045-15616-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 19:09:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKslg-0008J8-F7
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 19:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933723AbbBISJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 13:09:03 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:38091 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933717AbbBISJB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 13:09:01 -0500
Received: by iecrd18 with SMTP id rd18so6442415iec.5
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 10:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IcFDTAhE7e8vq1qv/W8XsF8/JdB0WIZrx3lXcSvkqqQ=;
        b=P6B41o21Waq+K/+Ocm3wdk2nEW0ZTCI5Ksm5Je3JEmdY06vmQ6GWOd195ErTc3BInA
         MGFxHs5AuAgOwv905y+WFzzbuwoSoxRkFJx6tIHPULUo0Tos6Nn7g0FwqIMpIQmcGHwZ
         K6nCMnnziWriEkxhH7VDtbdQQyxqFAimUzcbp+UfO2rdWF+rT20blbhO/v63tt1+S6J+
         u2K29AdjsqCGUEsFmhth1Fh1uWjhFz9rsWG5Ld2oCnhi8lTBYle95VdUUgDQ5DA6L+77
         pO3imcRyVft169IsM9SSC9sJH6+iOD5uP1qDG+YB+AQ1pnn3oJmxGSVxUJcEe1C6czxp
         CXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IcFDTAhE7e8vq1qv/W8XsF8/JdB0WIZrx3lXcSvkqqQ=;
        b=DYPNsUncMU63xdj3OJp/PCxfyyFxlJyrveaqgH6/qWgOEpsjA8iJjx0uJwoNY7rMYi
         +84i153ONtCslGVVy1/y6aDyBjGZ3Dn1GVd1/WY1OWHZqcD3J/Hw6cviOOjECU2SIGHg
         qQdRgL3YfKpoOIAVD1nOGxSrPu/QsLnU2Iz0cpy0OQJqRM+Lm7wl0fpy8VHXt6OYwNw9
         D8CNXmDG1OYbxWm2eu6Pb4DqZXMAvmkekW+6JJpEJlakooop86CS82E3CMI0oJnhU2pj
         oFWNXiiPFdzgkXQSa/0QPMiWqq4pc0smwcXXfrh0sGFTCIObOzzi5bkVeJHOAHqN0odA
         1cfg==
X-Gm-Message-State: ALoCoQkAKrsgIMk6ElMKROO719BqMUCm9MG95EsozUy0dHqxYt2YPnWGoRjvh6OmSKY1ILe+fEHm
X-Received: by 10.50.85.44 with SMTP id e12mr18735433igz.48.1423505341141;
 Mon, 09 Feb 2015 10:09:01 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Mon, 9 Feb 2015 10:09:01 -0800 (PST)
In-Reply-To: <1423412045-15616-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263569>

On Sun, Feb 8, 2015 at 8:13 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> It is only used internally now. Document it a little bit better, too.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>

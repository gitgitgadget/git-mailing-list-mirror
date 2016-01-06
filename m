From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] clone: use child_process for recursive checkouts
Date: Wed, 06 Jan 2016 18:41:37 -0500
Organization: Twitter
Message-ID: <1452123697.3892.112.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
	 <c21eb4a5d3a3a4886c45da0abe307fe1772e932e.1450869637.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 07 00:41:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGxi5-0002QG-7d
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 00:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbcAFXlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 18:41:42 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34364 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbcAFXlj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 18:41:39 -0500
Received: by mail-qg0-f46.google.com with SMTP id 6so237317731qgy.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 15:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=bFyAl2UsFpALgdU6f9lZ13sBUA4Ne7sF+YgbSXlohLo=;
        b=QPUeO6tS53kDE5HYFt1CCX/mFbHrN8cPboIgYr2vFBFW0q/sGgSw9zfe0YGaLUiyOt
         AJrb1P3/3rPxGUfpEw8unnblBx+y27mnCEvJQN3K0B+9GJDSEG/OpYznX9XtPqa3zevG
         5R5XKisA4fKPrEFgTf9Z7TuxNlUz7XmygQLtM3uTOhZIf6YbKqyGmPhzY2uBDCDpJ589
         KKVI/zHu8y39wS/AHe2qwJAORwXwOnj+157n1/Morphoz5fbSVHG6w/DLO0b8Edas+04
         ntyQKZnF56qRGDpAaGPjCDsKY6Dr0WOyocUpP/v+h3SJo8EYsA6wxJE8SnTuGEJTwGU4
         NovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=bFyAl2UsFpALgdU6f9lZ13sBUA4Ne7sF+YgbSXlohLo=;
        b=dIK2rIGj5f+mjxPdwwPtTOAJPeXFRsQ/jxYwe1aWDEWxcb+bCY8C26yV6wgPAsMP6J
         iVOZcVfRgNMr5QyoDL+d8anXWvf5lGJ4oK+wN3q2Ni5qZroK86KwhLBhncPbyamIe8yx
         wo2qDFN0LOPOjW/GIwRwpokKgFHX05TEgF7M82EvXo1iFsbsXLmt4qCFQBjTG/PK2Jmf
         xr+mZ0C/rJIeXnO3pyH2rGpmliX4AZc86LMdBBhqPN2bxbZHGzeuwIAI0c276BP/jnW0
         TL1bojQwlWpmBDfua31gXude5N9eo+GRzs47qAw/kADIen+7vz8V0RId2bUSItRx8Wh0
         uz+g==
X-Gm-Message-State: ALoCoQnOaDcoqvuVKrc9Zu28Hy3H358iFSv2KKF1d4vx7hmipOqvbf1fmvird4ACmMcWVAR9vAnCoRvhxfzef4utCoodx4WRwQ==
X-Received: by 10.140.102.246 with SMTP id w109mr131772725qge.58.1452123698859;
        Wed, 06 Jan 2016 15:41:38 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f132sm27112283qhe.6.2016.01.06.15.41.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jan 2016 15:41:38 -0800 (PST)
In-Reply-To: <c21eb4a5d3a3a4886c45da0abe307fe1772e932e.1450869637.git.mhagger@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283458>

On Wed, 2015-12-23 at 12:30 +0100, Michael Haggerty wrote:
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> David, I think if you insert this patch before your
> 
>   13/16 refs: allow ref backend to be set for clone
> 
> , then the hunk in builtin/clone.c:checkout() of your patch becomes
> trivial:
> 
> 	if (refs_backend_type)
> 		argv_array_pushf(&cmd.args, "--refs-backend-type=%s",
> 				 refs_backend_type);

Inserted, thanks.

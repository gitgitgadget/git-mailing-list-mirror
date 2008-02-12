From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] pack-objects: Add runtime detection of online CPU's
Date: Tue, 12 Feb 2008 12:18:57 +0100
Message-ID: <36ca99e90802120318y5099b06cta3f8488dc758f6@mail.gmail.com>
References: <47B156CD.1010209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Feb 12 12:20:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOtB5-00065f-4e
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 12:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759923AbYBLLS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 06:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752952AbYBLLS7
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 06:18:59 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:44801 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbYBLLS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 06:18:58 -0500
Received: by py-out-1112.google.com with SMTP id u52so7299630pyb.10
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 03:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SroIgfIrzxVRKybvGQ9h989jbXokJL0D1lzesj9c6Rg=;
        b=lEX54rZthGxhWZmIMGjj7BUPcEo6AmSrkkhqA5FIt4+yOwQEJqXHSMsToUlDX1C+MQQlXBjcvaW5h/rEQttgxiNHKDy0imTXCIQvL28kAXkg+iSSeiMsoVdUDKKv+76QKb8co6De41Wz/nJcVH2OiG9xcCAmvDHDu9bNDR544WI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l17IbZS4VWEB5uvDHtACG4yJSvg1v8goJvcVlzkEZ5SUAYvXcJ3WiC/xCOJsHLqdhOsGDdOFvdHds/33P2TECek7T8PAtOajBdmKKmyhNJzPV7a+PjKiklr72ZZ4++J3lp/2tiw5q5sZT5q4SO2y2zwZAbj9on8RHZuOPveLLRM=
Received: by 10.35.103.6 with SMTP id f6mr1288515pym.45.1202815137089;
        Tue, 12 Feb 2008 03:18:57 -0800 (PST)
Received: by 10.35.37.3 with HTTP; Tue, 12 Feb 2008 03:18:57 -0800 (PST)
In-Reply-To: <47B156CD.1010209@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73650>

Hi,

On Feb 12, 2008 9:20 AM, Andreas Ericsson <ae@op5.se> wrote:
> +#ifdef THREADED_DELTA_SEARCH
> +# ifdef _SC_NPROCESSORS_ONLN
> +       long ncpus;
> +
> +       if ((ncpus = (long)sysconf(_SC_NPROCESSORS_ONLN)) > 0)
> +               return (int)ncpus;
> +# else
I can't find the right pointer, but for linux it would be more usable
to use sched_getaffinity(). Than you can do thinks like this:

$ taskset 0x3 git gc ...

and you will get 2 cpus, even 4 are online.

Bert

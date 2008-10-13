From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] compat/cygwin.c - Use cygwin's stat if core.filemode
 == true
Date: Mon, 13 Oct 2008 00:31:53 -0400
Message-ID: <48F2CF39.5040000@gmail.com>
References: <20081012133934.GB21650@dpotapov.dyndns.org> <1223837086-2864-1-git-send-email-mlevedahl@gmail.com> <7vskr1fvys.fsf@gitster.siamese.dyndns.org> <48F25CB6.10702@gmail.com> <7vd4i5fkny.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, dpotapov@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 06:33:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpF75-0004dT-LS
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 06:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbYJMEbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 00:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbYJMEbd
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 00:31:33 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:44059 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbYJMEbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 00:31:32 -0400
Received: by gxk9 with SMTP id 9so3137143gxk.13
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 21:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=G95rG72eio9ZR85ijTvoh9OaiqUaIJiEMRqD+qEnBcY=;
        b=bZm4DSPty2irX0MKRTPWZbyP7SRaocjj0ZR7rVM9TCE9a916WfYF71BNxTCrzOwv/c
         jxcD/fwbUzL0voYrOy219HRi22BLbdDvIHjx55vp6yChdMVoTVOsy9c51EqBAP16Roeq
         h6W2WhAjDGcXXzz7g3DfYUiUeVn1Ws8qJLMow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qPJTpHp7Gl6kzuh1vEc7fnzq3kog3/qIqTwpjk4a5v+Oe4PkPMB87j/p9XhWd7SSbX
         72qjTKu9kKGslY9PBghe7A+naf2lkVe64f+lEYwZJ5GIjI2P5OaZIjMrSsTiXOaeKbmc
         b1iOJN7DWVCiOeiUbPJixzPSeIjyJpCrKzzk4=
Received: by 10.151.155.5 with SMTP id h5mr7352882ybo.49.1223872291644;
        Sun, 12 Oct 2008 21:31:31 -0700 (PDT)
Received: from ?192.168.1.117? (pool-72-83-157-161.washdc.fios.verizon.net [72.83.157.161])
        by mx.google.com with ESMTPS id v76sm7904853rnb.5.2008.10.12.21.31.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Oct 2008 21:31:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <7vd4i5fkny.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98081>

Junio C Hamano wrote:
> I was wondering if git_cygwin_config() was originally written not to call
> git_default_config() because some command implementations do not to want
> to call git_default_core_config() (and/or read trust_executable_bit
> variable from the configuration) for some reason (which would be just
> hiding bugs in other parts of the system, I suspect).
>
> If that is the case, we would have to fix such broken parts of the system,
> but until that happens your original patch to use a separate variable and
> keeping trust_executable_bit untouched would be much safer than this
> latest patch.  Hence the question.
>   
I was worried about altering the startup code, which is why I tried to 
introduce as little change as possible. However, having rewritten the 
patch using git_default_config() everything seems fine (the testsuite 
passes, or at least as well as it usually does under Cygwin, and I 
assume that is sufficient as this is Cygiwn specific). So, that patch 
follows.

Mark

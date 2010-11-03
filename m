From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv7 5/6] commit: --squash option for use with rebase --autosquash
Date: Wed, 03 Nov 2010 02:20:16 -0700
Message-ID: <4CD12950.2080901@gmail.com>
References: <1288727952-57498-1-git-send-email-patnotz@gmail.com> <1288727952-57498-6-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pat Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 10:20:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDZW8-0005Sq-RP
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 10:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab0KCJUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 05:20:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50074 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab0KCJUW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 05:20:22 -0400
Received: by iwn10 with SMTP id 10so544034iwn.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Bk4S2JxzGMB8SSMm8iwxvHafo4d5X4QAuoMhBP1Gvts=;
        b=W3GUkp1gMnDMsKHNlxQCPlYMjv0RsnRSQ19zMTAoROB4YwITneEjzf79eB+Wb/ELM4
         nb4YqCX1IspeBwFYUIiS2dfK5APDhIE4lSFSGogTfxZqI9tzchd6HqKSL40b1ITTxQmV
         E/niWkYLHolw+gMnx+2lp+VI4GMFt/gvKDxu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=sh/0lN7x/cbKj/BIpprSFirJyyo+LpCdtCV3qcibXsKKp2Z203C7SShkAkcAehCQF1
         ckpzOeauX/Wz/EUD4uupxPpR6cQ0ZBjpuTrEOf3KJhmntGArqN0NdlWtNEq2YHt34Jz9
         EtGQizMmANK0iWfRrPUkHSWof/19CrW3kuM4Y=
Received: by 10.231.34.6 with SMTP id j6mr8485744ibd.93.1288776022059;
        Wed, 03 Nov 2010 02:20:22 -0700 (PDT)
Received: from [192.168.1.105] ([75.85.182.25])
        by mx.google.com with ESMTPS id 34sm11069410ibi.14.2010.11.03.02.20.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 02:20:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.11) Gecko/20101025 Lightning/1.0b3pre Thunderbird/3.1.5
In-Reply-To: <1288727952-57498-6-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160591>

Sorry if I've missed earlier versions and this has already been
answered. You can carry forward Cc's if you like and thus earlier
commentators will be more likely to re-review your code.

On 11/02/10 12:59, Pat Notz wrote:
> +--squash=<commit>::
> +	Construct a commit message for use with `rebase --autosquash`.
> +	The commit message subject line is taken from the specified
> +	commit with a prefix of "squash! ".  Can be used with additional
> +	commit message options (`-m`/`-c`/`-C`/`-F`). See
> +	linkgit:git-rebase[1] for details.

This doesn't mention the editor being invoked. The editor is invoked
only with certain option combinations right? I'm expecting this:

uses editor
------------
--squash
--squash -c
--squash -t
--squash -eF
--squash -eC
--squash -em
--squash --amend

doesn't use editor
------------------
--squash -C = no editor
--squash -m = no editor
--squash -F = no editor

I haven't thoroughly checked the code to make sure that's happening.

> @@ -619,6 +639,16 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	else if (in_merge)
>  		hook_arg1 = "merge";
>  
> +	if (squash_message) {
> +		/*
> +		 * If squash_commit was used for the commit subject,

squash_commit or squash_message?

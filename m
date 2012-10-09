From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: 'git grep needle rev' attempts to access 'rev:.../.gitattributes'
 in the worktree
Date: Tue, 9 Oct 2012 16:38:32 +0700
Message-ID: <CACsJy8BFmUr5_E47900T6j9Lgdvj96_dNbo2LHP5hLYq3w7ZLA@mail.gmail.com>
References: <5073E87D.9020100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 11:39:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLWHi-0006yv-9V
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 11:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab2JIJjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 05:39:06 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62906 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab2JIJjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 05:39:03 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1480597iea.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xFIPJp5oNokz1Rh3ah1pZKKsGrHMRZ5QN9IAOtJA23c=;
        b=btEbJbm/HxvxxxXtZgPxhFNjzIk5meuxV9Kb5xV0ROxoov9hotv52q7e0bA4CNYs37
         N3QUuovQn5f5JkHkGu5RJnSysFy/lEcjTasjIXn/t5nD4lgifh/CnlKgNggg5U71enEL
         oaetCBZU47hePs7JEhja+kLdfkuKwEcTJwqlRxVRvjsgjiaF9zMN/xb+z53UCKJEuAec
         9cMxCYEq0Rx5lW7JirPGhrutyoRzPCcptl4j3TDIUCuqJlF27s1oKTk5HwMpYNG8R8zQ
         bP7JERRIyPZ2tvDb0d9mBFQoyG/5ij5ia2tkKLlTWBe/I8Ps1RvD+8Ijf3IjjkhtaXL/
         resw==
Received: by 10.50.0.241 with SMTP id 17mr1063725igh.40.1349775543358; Tue, 09
 Oct 2012 02:39:03 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Tue, 9 Oct 2012 02:38:32 -0700 (PDT)
In-Reply-To: <5073E87D.9020100@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207313>

On Tue, Oct 9, 2012 at 4:03 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Running 'git grep needle origin/master' on Windows gives numerous warnings
> of the kind
>
> warning: unable to access 'origin/master:Documentation/.gitattributes':
> Invalid argument

strace confirms it. Stack trace

#0  read_attr_from_file (path=0x820e818
"HEAD:Documentation/.gitattributes", macro_ok=0) at attr.c:351
#1  0x080d378d in read_attr (path=0x820e818
"HEAD:Documentation/.gitattributes", macro_ok=0) at attr.c:436
#2  0x080d3bf1 in prepare_attr_stack (path=0x820e7f0
"HEAD:Documentation/.gitattributes") at attr.c:630
#3  0x080d3f68 in collect_all_attrs (path=0x820e7f0
"HEAD:Documentation/.gitattributes") at attr.c:747
#4  0x080d3ffd in git_check_attr (path=0x820e7f0
"HEAD:Documentation/.gitattributes", num=1, check=0xbfffd848) at
attr.c:761
#5  0x0815e736 in userdiff_find_by_path (path=0x820e7f0
"HEAD:Documentation/.gitattributes") at userdiff.c:278
#6  0x081058ca in grep_source_load_driver (gs=0xbfffd978) at grep.c:1504
#7  0x08105907 in grep_source_is_binary (gs=0xbfffd978) at grep.c:1512
#8  0x08104eaa in grep_source_1 (opt=0xbfffe304, gs=0xbfffd978,
collect_hits=0) at grep.c:1180

Never touched userdiff.c before. Anybody?
-- 
Duy

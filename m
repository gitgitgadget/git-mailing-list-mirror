From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: 'git grep needle rev' attempts to access 'rev:.../.gitattributes'
 in the worktree
Date: Wed, 10 Oct 2012 12:45:21 +0700
Message-ID: <CACsJy8AoLvWc9NCkqX_gEiBwLZDDx7TA9_CEMmXbb=k8iDS7_Q@mail.gmail.com>
References: <5073E87D.9020100@viscovery.net> <CACsJy8BFmUr5_E47900T6j9Lgdvj96_dNbo2LHP5hLYq3w7ZLA@mail.gmail.com>
 <20121009120144.GA8780@do> <20121009124144.GB12465@sigill.intra.peff.net>
 <7vk3uzfp3p.fsf@alter.siamese.dyndns.org> <CACsJy8Cku-XTbQBDpZpPh7AMDFMoNKLKeJNs5HKCQnBy420d2w@mail.gmail.com>
 <7vwqyydh6v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 07:46:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLp7K-0003ab-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 07:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172Ab2JJFpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 01:45:53 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:35869 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab2JJFpw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 01:45:52 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so183584qaa.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 22:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v8ci9A6J3/nuHJKfs4V+wKVpLoaJITGxzUPkAJ8G8Hw=;
        b=wu+6DLx/dkSfXnz5nyMglrwZbO50eJCn8b4hNDkPlrWpYCskpiOY87UMcS2PzKHAA7
         7ZEd8KVe/iqK+pXys8hR8MTxoTmGUQuy4mNVTW9s7cYB4u/KprOcKpNvPTZCbTM4Jxbx
         /tBAotKADrc2SKnxdE5rKwjGhMvdANkC+zqDVAR1jg82S5OlIJ//Ggj9C+MI9Dt2AAHS
         9+meSq+ZaU8vycpnhV3HD6OYbAdmWIckP2pzzfstCZyB7eWtnjBYxRvt/3dXCsDoYiBR
         gaiUrcHI8DtG492hwvh8OPL6UyvTeZRLrJ9P2cUixE8K+az0nMLxjCNrI559DZVOsuHR
         U82w==
Received: by 10.224.180.132 with SMTP id bu4mr38110252qab.62.1349847951634;
 Tue, 09 Oct 2012 22:45:51 -0700 (PDT)
Received: by 10.49.13.194 with HTTP; Tue, 9 Oct 2012 22:45:21 -0700 (PDT)
In-Reply-To: <7vwqyydh6v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207366>

On Wed, Oct 10, 2012 at 12:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Wed, Oct 10, 2012 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> I think we just need to have callers of grep_source_init provide us with
>>>> the actual pathname (or NULL, in the case of GREP_SOURCE_BUF). That is
>>>> where the information is lost.
>>>
>>> Yes.  I agree that is the right approach.
>>
>> Passing full path this way means prepare_attr_stack has to walk back
>> to top directory for every files (even in the same directory). If
>> .gitattributes are loaded while git-grep traverses the tree, then it
>> can preload attr once per directory. But Jeff's approach looks
>> simpler.
>
> Why can't you do both?  That is, to build a full path as you
> descend, and read per-directory .gitattributes as you go?

Hm... I need to check attr.c code but I think it means read
.gitattributes and prepare attr stack in builtin/grep.c (where we
traverse trees) and actually check the attribute in
grep_source_load_driver(), much further down the call stack. I'm not
sure how we can pass the prepared attr stack down to
grep_source_load_driver().
-- 
Duy

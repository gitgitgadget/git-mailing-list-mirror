From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Maildir ordering in git-mailsplit (was: Using mutt as a git maintainer)
Date: Sat, 07 Aug 2010 06:23:46 -0700 (PDT)
Message-ID: <m3eieao8uh.fsf@localhost.localdomain>
References: <20100806222847.GA4240@sceen.net> <20100807024337.GA15410@kytes>
	<20100807112159.GA12015@sceen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Richard Braun <rbraun@sceen.net>
X-From: git-owner@vger.kernel.org Sat Aug 07 15:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhjNU-0007Kf-5O
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 15:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762630Ab0HGNXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 09:23:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48031 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab0HGNXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 09:23:49 -0400
Received: by fxm14 with SMTP id 14so4332704fxm.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ETBUjLd2YKo6RNeAIJMKFZUdyUApz5IjhBW2ye8appk=;
        b=thjEwC8L0ec6NUDvofbwY/OqU86MCscCaeXHBcMDVqxiunyZ43EqOH+evPZ7am17Zb
         jMyveYA+rduid5Njdx3LpGTN8LDlBoyYHNfTbTyqf3JYXeS1bDazQPYSyWEeZr0kyDNR
         JkzqayNSBnTkFrzaJdOgaOOcmyM2+ZwRU3EoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=DACb62oNBf5kNocgEkBn44ca+G1NqAmqVzzCei4pD7LP8Ioayj6g2Tyw6Qc+L4Lwff
         AkGJOAi5jKNXGvmMSozH2y3iVVXeDvkCYOWtSBPTD8ciiECFvnfFiLd0sfGstvkfLiG9
         4wZ9WERc0CpfDw/fq/yV63RX10q2ZMcj39Fa0=
Received: by 10.223.119.210 with SMTP id a18mr14227972far.52.1281187428302;
        Sat, 07 Aug 2010 06:23:48 -0700 (PDT)
Received: from localhost.localdomain (abwi49.neoplus.adsl.tpnet.pl [83.8.232.49])
        by mx.google.com with ESMTPS id b36sm1037922faq.11.2010.08.07.06.23.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 06:23:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o77DNFhV004539;
	Sat, 7 Aug 2010 15:23:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o77DN3A8004533;
	Sat, 7 Aug 2010 15:23:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100807112159.GA12015@sceen.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152856>

Richard Braun <rbraun@sceen.net> writes:
> On Sat, Aug 07, 2010 at 08:13:39AM +0530, Ramkumar Ramachandra wrote:
> > 
> > Ah, it looks like this problem went unnoticed probably because
> > everyone uses mboxes. One possible solution would be to teach
> > `git-mailsplit` to order the emails correctly. You can reply with an
> > RFC patch; I've CC'ed the Git list on this email.
> 
> Well, if everybody else has survived for five years with mbox patch
> series, I guess I can do that too. With some not-so-difficult work, I
> managed to have Mutt do what I wanted (that is, saving patch series in
> mbox files in one macro and keep everything else with Maildir folders
> untouched).
> 
> After some digging in the code, it doesn't look like a git issue. When
> a Maildir folder is processed, its entries are actually sorted, unlike
> what I first thought. populate_maildir_list() calls string_list_insert()
> (in string-list.c) which does insertion sort through its static
> add_entry() and get_entry_index() functions which use a bare strcmp() to
> compare file names (it was path-list.c back in Git 1.5, same code).
> When copying a threaded patch series in a Maildir folder with Mutt, here
> are the names created:
> 1281177008.8677_101.myhostname:2,
> 1281177008.8677_103.myhostname:2,
[...]
> 1281177008.8677_11.myhostname:2,
> 1281177008.8677_13.myhostname:2,
> 1281177008.8677_15.myhostname:2,
> 1281177008.8677_17.myhostname:2,
> 1281177008.8677_19.myhostname:2,
> 1281177008.8677_1.myhostname:2,
> 1281177008.8677_21.myhostname:2,
> 1281177008.8677_23.myhostname:2,
> 
> And for such names, git am determines that e.g.
> "1281177008.8677_107.myhostname:2", should be applied before
> "1281177008.8677_17.myhostname:2,", which is obviously wrong.
> 
> I'm not sure about what depends on string-list.c, but based on the
> output of a raw grep, it doesn't seem like a good idea to change the
> way strings are sorted, especially if almost noone uses Maildir for
> patch series. [...]

Would it be really that difficult to implement "version sort" in git
(like 'ls -v' / 'ls --sort=version' does), using strverscmp (and
provide fallback in compat/), and use it in git-am?

-- 
Jakub Narebski
Poland
ShadeHawk on #git

From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] sendemail: teach git-send-email to list aliases
Date: Mon, 16 Nov 2015 18:30:16 -0500
Message-ID: <CAPig+cQ929oAZqQM+X68x3PVQ-opwdi3VzjcQTUsaCfVK3411g@mail.gmail.com>
References: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:30:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyTE7-0006LH-4r
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 00:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbbKPXaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 18:30:18 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34537 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbKPXaR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 18:30:17 -0500
Received: by vkgy188 with SMTP id y188so171012vkg.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 15:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Aiz+S+ZdmjP1mUdUno7Hyuyy+v/7cbg/bRR0KXWYF1I=;
        b=oQ0ha4jrZpLbmpoyKSx0DoYLJyCHnGcb0SxN7z0/t2A/9A/WghmsSXSXzOy7Yx4E1R
         uxRHgLXhfJZTKweuZNhwUHmpE7pQy7y6jF4lQMKtNa5pUbwbDw4sAIJxkOU8su61Ydiv
         r1b7G83LeZUNe8ZcbzTNCc6hvtjR0gQ91zgEmyIqqMhDbghceKcmVhLVi8sZuehbosKS
         aG9lOObThepMhrUoFJ9cCH1vU/ETMC9J7vnnsiLjNEodPPDPeerJG7KEQTlrKI9BEBj5
         vCFjoK6grYpxnzkovDelnY/LRzLuTvDXdUlyODTwr93l+lEGp55eSrAsxlkFzEaDJFol
         MSYw==
X-Received: by 10.31.159.133 with SMTP id i127mr548425vke.37.1447716616842;
 Mon, 16 Nov 2015 15:30:16 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 16 Nov 2015 15:30:16 -0800 (PST)
In-Reply-To: <1447618940-27446-1-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: 11yV54rHyNeQKOJs3ZcDimDISO0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281364>

On Sun, Nov 15, 2015 at 3:22 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Add an option "list-aliases" which changes the default behavior of
> git-send-email. This mode will simply read the alias files configured by
> sendemail.aliasesfile and sendemail.aliasfiletype and print a list of
> all known aliases. The intended usecase for this option is the
> bash-completion script which will use it to autocomplete aliases on the
> options which take addresses.

As this is primarily a plumbing option, I wonder if --dump-aliases
might be a more suitable name.

Also, is it possible that some consumer down the road might want
richer output which includes the expansion of each alias? For
instance, it could emit the alias name as the first token on each line
and the expansion as the remainder. Consumers interested in only the
alias name would grab the first token on the line and ignore
everything else.

> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -101,6 +102,9 @@ git send-email [options] <file | directory | rev-list options >
>                                       `git format-patch` ones.
>      --force                        * Send even if safety checks would prevent it.
>
> +  Information:
> +    --list-aliases                 * read the aliases from configured alias files

This description is odd. It seems to imply that aliases will be loaded
(and used) only if this option is given, and says nothing about its
actual purpose of dumping the aliases.

Also, with one exception, all the other option descriptions are
capitalized. This probably ought to follow suit.

> +if ($list_aliases) {
> +    print $_,"\n" for (keys %aliases);
> +    exit(0);
> +}

New test(s) seem to be missing.

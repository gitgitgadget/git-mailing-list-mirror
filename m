From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg redepend: New command.
Date: Mon, 1 Sep 2008 11:31:15 +0200
Message-ID: <36ca99e90809010231o439ab4acsaa3027366c551ff6@mail.gmail.com>
References: <1218808427.25300.2.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, "Jan Holesovsky" <kendy@suse.cz>
To: "Jan Nieuwenhuizen" <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Sep 01 11:32:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka5lq-0004Xy-AV
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 11:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbYIAJbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 05:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbYIAJbU
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 05:31:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:29808 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbYIAJbT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 05:31:19 -0400
Received: by wx-out-0506.google.com with SMTP id h29so530045wxd.4
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qjSWbvibwLetZwUlaVLkdBoyPwK12Gf+z3vxttgvC+8=;
        b=SzdYZb/Slp703QM4KPcg7F1JhhiLGr8Nu//JZZm9oAKp6CmBFd0eYV4TYyi3GjTNWV
         3V/Kw/RPbjoD5u5Ls4NijEmtRQ757uisc75cf57ixOatXGE57cp3j/YbVgmKwEonJz6V
         HQILlhgdwmpI/Arxo1yIDuTCL140VkN13emjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pyxH2xQCYfEFuqsnW1zCJxxGNOB+CmLLmKvJTENO9awpnsgiSYtoxeapwM7UJaYf3z
         NdRNnnC5Q8Z2hTR9zXjGiDpfpvxco00fW6Y/EL9HHa9uQEwZWADYyVCdUkSFHZFVdzAZ
         ikyedKZ9ujKolJggnWtiDRwvO+zosAWtKzoUg=
Received: by 10.70.56.13 with SMTP id e13mr7640245wxa.77.1220261475764;
        Mon, 01 Sep 2008 02:31:15 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Mon, 1 Sep 2008 02:31:15 -0700 (PDT)
In-Reply-To: <1218808427.25300.2.camel@heerbeest>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94547>

Hi,

On Fri, Aug 15, 2008 at 15:53, Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
> As discussed previously
>
>    http://kerneltrap.org/mailarchive/git/2008/8/13/2925144
>
> Change a topgit branch's dependencies by doing a rebase-by-merge.
>
>
is this script in use by you, or is it abandoned in favor of another idea?

Anyway, I have tried it today but it looks like the top-bases wasn't
updated to the new deps. It points still to the old base. Second, I
got an empty line in my .topdeps file.

> +
> +if [ -n "$add" ]; then
> +       add="${add/# }"
> +       add="${add//  / }"
> +       dupes=$(grep -E "^${add// /|}/\$" "$root_dir/.topdeps" | tr '\n' ' ')
> +       [ -z "$dupes" ] || die "already depend on: $dupes"
> +       redeps=$(echo "$add" | cat "$root_dir/.topdeps" - | tr '\n' ' ' | sed -e 's/ \+$//')
> +elif [ -n "$remove" ]; then
> +       remove="${remove//  / }"
> +       remove="${remove/# }"
> +       avail=$(grep -E "^${remove// /|}/\$" "$root_dir/.topdeps" | sort | tr '\n' ' ')
> +       remove_sorted=$(echo "$remove" | tr ' ' '\n' | grep -v '^$' | sort | tr '\n' ' ')
> +       [ "$avail" = "$remove_sorted" ] || die "not depending on some of: $remove"
> +       redeps=$(grep -vE "^${remove// /|}/\$" "$root_dir/.topdeps" | tr '\n' ' ')
> +fi
IMHO all these "| tr '\n' ' '" aren't needed. bash do the right thing here.

Bert

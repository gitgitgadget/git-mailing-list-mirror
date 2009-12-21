From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git's fascination with absolute paths
Date: Mon, 21 Dec 2009 17:09:29 -0500
Message-ID: <32541b130912211409j540928c0g8e944fcc05c44f82@mail.gmail.com>
References: <4B2FC17A.3010705@math.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: J Chapman Flack <jflack@math.purdue.edu>
X-From: git-owner@vger.kernel.org Mon Dec 21 23:09:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMqRv-0003E9-ND
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 23:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757312AbZLUWJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2009 17:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757283AbZLUWJu
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 17:09:50 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:35280 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbZLUWJt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2009 17:09:49 -0500
Received: by ywh12 with SMTP id 12so6122766ywh.21
        for <git@vger.kernel.org>; Mon, 21 Dec 2009 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TQEi8aJNfjVs3Cs4obKFRI/lEhSaVz8NxCRxTddmG3k=;
        b=FY4u3md4CBDBqcJIRWjdtpa/GQ+dPHcW+mjZU06TpbNb0hqlVL/1ffwcslA3uUtQYb
         2WkXtm2Tz+0kuUHtOqRbfTj4xcOpz2R3zrLAAyp68ZCY7anx/xw4cXDqdtCmgJq6JIDj
         0IyAhiCoZ03+T8R/Fzx6OY+C8h1svje73muqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dN5GiId5RZ8ME7JssmNqttXbsrqpU9Po/bBJin1+sQgszFxin62A3BFbXjQYLxNIli
         kzvJEr8+UDpneFjtdT4JcXIeHE2awh2Ol/ACrJwbiHVI5Uuvrst9BiHYbt5hPA7PwDl7
         SGnmE+LdePPJQOpGBFZ9h+au7hcP6TckDns9k=
Received: by 10.150.251.4 with SMTP id y4mr6314741ybh.89.1261433389079; Mon, 
	21 Dec 2009 14:09:49 -0800 (PST)
In-Reply-To: <4B2FC17A.3010705@math.purdue.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135566>

On Mon, Dec 21, 2009 at 1:42 PM, J Chapman Flack <jflack@math.purdue.ed=
u> wrote:
> In general it seems best for a program to stay free of assumptions
> about absolute paths except when there is a specific functional
> requirement that needs them. =A0I assume there is something git does
> that requires it to have this limitation, but it's not intuitive
> to me if I just think about what I expect an scm system to do.
> I've searched on 'absolute' in the list archive to see if there
> was a past discussion like "we've decided we need absolute paths
> everywhere because X" but I didn't find any. =A0Can someone
> describe what the reasoning was? =A0A security concern perhaps?
> (And one more serious than the race condition built into
> make_absolute_path?)

I think it's probably just because it's easier to deal with absolute
paths than relative ones.  Those ".." things can be annoying,
particularly inside scripts, etc, and git uses a lot of scripts.  Much
more straightforward to just normalize all the paths once and be sure
there are no weird dots in them.

Not to say that it can't be done... just that it seems nobody has been
inspired to do so.  I'm guessing most of the existing developers still
won't be inspired to do it based on your rather unusual use case;
however, they might accept patches.

> Or, perhaps I should be asking, what is there in git that will
> break if I recompile it with make_absolute_path(p){return p;}?
> Does it store absolute paths in the db? =A0Would a recompiled
> version produce a db other gits couldn't read?

You might try this and then see what happens in 'make test'.  I
imagine a set of clean patches that removed a lot of assumptions about
absolute paths, without breaking any unit tests, would be something
worth considering for integration into git.

Have fun,

Avery

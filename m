From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH v2] Add --exclude to git-clean.
Date: Mon, 19 Jul 2010 14:22:33 -0400
Message-ID: <20100719182233.GA4713@localhost.localdomain>
References: <bf4ea4e83162ebf1d915b87413aad54a1162a637.1279556172.git.jaredhance@gmail.com>
 <7vbpa3pdtc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 20:22:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OauzO-0007cS-Km
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 20:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760843Ab0GSSWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 14:22:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34401 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760784Ab0GSSWi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 14:22:38 -0400
Received: by vws5 with SMTP id 5so4965721vws.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ja6rqO7+BUP6Im+HI1zc0HXA1xj1aY3qF/hXGVLQNEY=;
        b=kqFuiqQTCsBrLRy61mXaBRzjfJW/MCDKzwoKQYcN9uYym8Sme+sJuggykgoXMHpMvF
         b38JS9dUNt7LjOpHXdkj80v0nRUMKzW62Wa2FpzX28CrP6fRF3nNuRijmT9c+cdWMfBr
         SH888flFilQkFW1R/xhQmnRBbU6dNsKnQEni0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oLRw4chQ++yT6bd4lYCbE2G27qHOPSvJhc101g7nOwMyXdxQbgX2S/JyaDkCH2mIJ4
         +Wy7sbHTDljFTCWgVi7q5IgJ7dhEHovIbnk/Mc0XDhgJKalH4SGaXwTrXPPUiSlmPNAJ
         5J8dVDA00ETRU8dvg57+gKi2gPTviaZcC/X80=
Received: by 10.220.169.14 with SMTP id w14mr3254393vcy.17.1279563758016;
        Mon, 19 Jul 2010 11:22:38 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id d12sm1343535vcn.14.2010.07.19.11.22.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 11:22:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbpa3pdtc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151266>

On Mon, Jul 19, 2010 at 10:43:43AM -0700, Junio C Hamano wrote:
> this both look wrong.  They do not tell the readers that the option takes
> a mandatory argument that specifies the "exceptions".  Worse yet,

Sorry about that. I will get that fixed.

> > +	Specify special exceptions to not be cleaned. Separate with colon.
> 
> this does not tell _how_ exceptions are specified.
> 
> What should each element on the list look like?
> 
> Is it a dot-suffix without dot (e.g. "html") or with dot (e.g. ".html")?
> Or is it a glob (e.g. "*.html")?  Or is it a full path relative to the
> worktree root (e.g. "Documentation/index.html")?
> 
> Using colon as an inter-element separator makes sense only if last one is
> true (i.e. "concrete path, not glob nor suffix"), so an intelligent reader
> could probably guess what you meant, but you shouldn't make readers guess
> in the first place.
> 
> If on the other hand you wanted to allow specifying the same kind of
> patterns used in the gitignore files from the command line:
> 
>  (1) A list separated with whitespace would be more natural, not a colon;
>      and

It is a global (like in the .gitignore file). I will change it to
whitespace. At first, I was worried about files with whitespace, and a
colon seemed to fit it better (since files don't have colons).

On the other hand, can you think of any character that would fit both
a glob and a strict filename (as it allows both)? I had trouble
figuring out what to use here.

>  (2) I have to wonder why do we give such a command line exclude override
>      to begin with.
> 
>      (2-a) wouldn't it be easier for the user to add such a local
>            configuration to $GIT_DIR/info/exclude once and be done with
>            it?

As I said earlier, its generally useful for files you are only going
to have for a few minutes and you don't want to have the clutter up
$GIT_DIR/info/exclude with them (since they probably won't ever
return).

>      (2-b) if command-line override has benefit, why is it limited to only
>            _exclude_ and not include (iow, additional ignore patterns)?

"git clean && git rm <INCLUDES>" has the same effect as including in
the clean.

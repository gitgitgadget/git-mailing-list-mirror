From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 13:26:33 -0700
Message-ID: <d411cc4a0808191326s35a56c1i2e20d82e3885298@mail.gmail.com>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com>
	 <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
	 <20080819185804.GA17943@coredump.intra.peff.net>
	 <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
	 <20080819190832.GC17943@coredump.intra.peff.net>
	 <20080819195928.GB24212@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 22:27:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVXns-0001n1-QG
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 22:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbYHSU0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 16:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbYHSU0g
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 16:26:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:29269 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164AbYHSU0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 16:26:35 -0400
Received: by yw-out-2324.google.com with SMTP id 9so8158ywe.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+p7/EPV/AdV7s0emXECxFqwXeoIs+BYLFgWsGz3tSQo=;
        b=HlHxm1txCqhAK6YLWqZWEIeCYrElPThNt+6nw/D3uirw0pYBKLH81nx7loNDGunhTX
         Kab/tEDTx9wrw1vjNSlgvDOelWVdnHA0XRF27bRca7zDK1g85A1KEQ6NlDtnVztuBvnP
         YQu5KA25QiF4uAuw5dqKG9jdTSPkSqgdLJTnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SsX6qX5zzl2D9Niv11BG5lNLnrPl2ukWUwwd3aTgJHipNh/gNB+qUeZHiWzH/GcOlx
         Q1z6sJaQyehATsHy4Mwe3twEh3pOgR1lDubmsD/jeA5sYdBjbFcYPhcNYeL586SkUyuI
         PGrPax2R6koPv0QhLsMO4ykzLNgkdC3+6Ti88=
Received: by 10.114.103.1 with SMTP id a1mr7215273wac.82.1219177593529;
        Tue, 19 Aug 2008 13:26:33 -0700 (PDT)
Received: by 10.114.170.3 with HTTP; Tue, 19 Aug 2008 13:26:33 -0700 (PDT)
In-Reply-To: <20080819195928.GB24212@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92920>

On Tue, Aug 19, 2008 at 12:59 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jeff King <peff@peff.net> wrote:
>> I think the common wisdom has been that such tests should be done on the
>> _receiving_ end, since that makes a more trustworthy enforcement point.
>> E.g., I know that crap can't get into my central repo because a hook
>> checks everything coming in. But if a developer has turned off his
>> pre-push hook (or accidentally failed to enable it), he can still send
>> crap.
>>
>> One other argument I have seen is that, to prevent the proliferation of
>> hooks, the rule is not to add a hook that could just as easily be done
>> as a sequence of commands. IOW, what's wrong with
>>
>>   run_my_automated_tests && git push
>
> Yup, I agree completely.
>
> Why not just setup an alias:
>
>        git config alias.send '! run_my_tests && git push "$@"'
>
> and retrain your fingers to use "git send ..."?
>
> --
> Shawn.

Sorry, but couldn't this argument be made about any of the hooks run
after manual operations?  ie: pre-commit, pre-applypatch, commit-msg,
post-commit, post-applypatch?  I mean, couldn't you do :

git config alias.docommit '! do_pre_commit && git commit ...' ?

I thought the point of these kind of hooks was to make stuff like this
automatic and easy to standardize for a project, so people working on
a dozen git repos don't have to remember all the aliases they set up
in each one.

Scott

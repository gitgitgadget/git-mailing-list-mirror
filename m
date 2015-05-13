From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH v2] bisect: improve output when bad commit is found
Date: Wed, 13 May 2015 13:25:12 -0400
Message-ID: <20150513172512.GA27231@tsaunders-iceball.corp.tor1.mozilla.com>
References: <1431472751-20974-1-git-send-email-tbsaunde@tbsaunde.org>
 <xmqqwq0dcrcf.fsf@gitster.dls.corp.google.com>
 <20150513005432.GF31257@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqqoalpcm9f.fsf@gitster.dls.corp.google.com>
 <CAP8UFD0VsJG6G=sP9mtkwwG30mZeiGwQLs_9d48Ovx=ws15YuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 19:26:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsaQM-0002Vp-Ai
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 19:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934366AbbEMR0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 13:26:21 -0400
Received: from tbsaunde.org ([66.228.47.254]:45534 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbbEMR0U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 13:26:20 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 0EF64C07C;
	Wed, 13 May 2015 17:26:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAP8UFD0VsJG6G=sP9mtkwwG30mZeiGwQLs_9d48Ovx=ws15YuA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268994>

On Wed, May 13, 2015 at 11:10:31AM +0200, Christian Couder wrote:
> On Wed, May 13, 2015 at 3:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Trevor Saunders <tbsaunde@tbsaunde.org> writes:
> >
> >> On Tue, May 12, 2015 at 04:24:00PM -0700, Junio C Hamano wrote:
> >>> Trevor Saunders <tbsaunde@tbsaunde.org> writes:
> >>>
> >>> > When the first bad commit has been found git bisect prints something
> >>> > like this:
> >>> >
> >>> >    <40 char sha1> is the first bad commit
> >>> >    Commit <40 char sha1>
> >>> >    ...
> >>> >
> >>> >    :100644 100644 10f5e57... a46cfeb... M  bisect.c
> >>> >    :100755 100755 ae3fec2... 65a19fa... M  git-bisect.sh
> >>> >
> >>> > The raw diff output is not really useful, and its kind of silly to print
> >>> > the sha1 twice.  Instead lets print something like this:
> >>> >
> >>> >    The first bad commit is
> >>> >    Commit <sha1>
> >>> >    ...
> >>>
> >>> According to +CCouder, this change will break existing people's use
> >>> cases.
> >>>
> >>> See $gmane/268881
> >>
> >> Well, technically he just said it might be that people are parsing the
> >> output and could be broken, but if you'd rather not take that risk then
> >> I guess we just have to leave things the way they are.
> >
> > FWIW.
> >
> >  - I personally do not agree that those who scripted around "git
> >    bisect" (as opposed to those who wrote scripts to be driven by
> >    the "bisect run" interface) are worth worrying about.  But I am
> >    not the whole of the Git world ;-)
> 
> You know in git-bisect.sh:bisect_run() we do:
> 
>                 if sane_grep "is the first bad commit"
> "$GIT_DIR/BISECT_RUN" >/dev/null
>                 then
>                         gettextln "bisect run success"
>                         exit 0;
>                 fi
> 
> so we are doing it too!

I saw that, and thought it was pretty gross.

> >  - I personally do not find two same 40-hex on two lines is silly at
> >    all.
> 
> I agree.

*shrug* I'd probably agree more if it came last after the more useful
information the first bad commit has been found.

> >  - I _do_ think diff-tree --raw output without recursive is silly.
> >    It is not useful for humans (it doesn't even give paths fully),
> >    and it is insufficient for scripts, which can grok more through
> >    information out of the 40-hex.
> >
> > So perhaps if we keep
> >
> >         <40 char sha1> is the first bad commit
> >
> > and then replace the diff-tree output with "show -s", then the
> > result would be good enough, I would say.
> 
> Yeah I agree.

sounds like we all agree about that part at least :)

> And for people who want something else we can implement config options.
> 
> For example a bisect.outputformat that could be used like in the

I'd been thinking of a config option that was a little more user
friendly than writing "The first bad commit is%nCommit %h%n..." but
doing it that way is both simple and might allow us to replace the
printing code in bisect.c with a default format string.

Trev

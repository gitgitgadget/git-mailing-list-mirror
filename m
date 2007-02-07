From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: git-fast-import
Date: Wed, 07 Feb 2007 19:18:40 -0300
Message-ID: <200702072218.l17MIeSD005420@laptop13.inf.utfsm.cl>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com> <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org> <20070206164441.GA4949@spearce.org> <200702070117.l171HGxr023213@laptop13.inf.utfsm.cl> <Pine.LNX.4.64.0702061832020.8424@woody.linux-foundation.org> <20070207055352.GB7138@spearce.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:19:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEv8C-0001gR-AW
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbXBGWTJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbXBGWTI
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:19:08 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42861 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030299AbXBGWTH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:19:07 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l17MIffr032049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Feb 2007 19:18:42 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l17MIeSD005420;
	Wed, 7 Feb 2007 19:18:40 -0300
In-reply-to: <20070207055352.GB7138@spearce.org>
Comments: In-reply-to "Shawn O. Pearce" <spearce@spearce.org>
   message dated "Wed, 07 Feb 2007 00:53:52 -0500."
X-Mailer: MH-E 7.4.2; nmh 1.2-20070115cvs; XEmacs 21.5  (beta27)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [0.0.0.0]); Wed, 07 Feb 2007 19:18:43 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2533/Wed Feb  7 11:20:47 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38981>

Shawn O. Pearce <spearce@spearce.org> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > Btw, one thing that might be a good idea to document very clearly:
> > 
> >  - in the native git format, the offset from UTC has *nothing* to do with 
> >    the actual time itself. The time in native git is always in UTC, and 
> >    the offset from UTC does not change "time" - it's purely there to tell 
> >    in which timezone the event happened.
> > 
> >    So 12345678 +0000 and 12345678 -0700 are *exactly*the*same*date*, 
> >    except event one happened in UTC, and the other happened in UTC-7.
> > 
> >  - in rfc2822 format, the offset from UTC actually *changes* the date. The 
> >    date "Oct 12, 2006 20:00:00" will be two _different_ times when you say 
> >    it is in PST or in UTC.
> 
> Here is the current language relating to date parsing in gfi:
> 
> Date Formats
> ~~~~~~~~~~~~

[...]

> +
> If the local offset is not available in the source material, use
> ``+0000'', or the most common local offset.  For example many
> organizations have a CVS repository which has only ever been accessed
> by users who are located in the same location and timezone.  In this
> case the offset from UTC can be easily assumed.

No, it can't. There are summer/winter times, etc.

> +
> Unlike the `rfc2822` format, this format is very strict.  Any
> variation in formatting will cause gfi to reject the value.
> 
> `rfc2822`::
> 	This is the standard email format as described by RFC 2822.
> +
> An example value is ``Tue Feb 6 11:22:18 2007 -0500''.  The Git
> parser is accurate, but a little on the lenient side.  Its the
> same parser used by gitlink:git-am[1] when applying patches
> received from email.
> +
> Some malformed strings may be accepted as valid dates.  In some of
> these cases Git will still be able to obtain the correct date from
> the malformed string.  There are also some types of malformed
> strings which Git will parse wrong, and yet consider valid.
> Seriously malformed strings will be rejected.
> +
> Unlike the `raw` format above, the timezone/UTC offset information
> contained in an RFC 2822 date string is used to adjust the date
> value to UTC prior to storage.  Therefore it is important that
> this information be as accurate as possible.

Say what? If I use the "raw" format with UTC offset, the offset is just
ignored then?

> +
> If the source material is formatted in RFC 2822 style dates,

"uses RFC 2822 style dates" would be better

> the frontend should let gfi handle the parsing and conversion
> (rather than attempting to do it itself) as the Git parser has
> been well tested in the wild.
> +
> Frontends should prefer the `raw` format if the source material
> is already in UNIX-epoch format, or is easily convertible to

"already uses Unix-epoch format, can be coaxed to give dates in that
format, or its format is easily convertible to it" sounds better to me

> that format, as there is no ambiguity in parsing.
> 
> `now`::
> 	Always use the current time and timezone.  The literal
> 	`now` must always be supplied for `<when>`.

[...]

> +
> If separate `author` and `committer` commands are used in a `commit`
> the timestamps may not match, as the system clock will be polled
> twice (once for each command).

Better fix that. It can't be that costly to call gettimeofday(2) once and
squirrel the result away for later use.

>                                 The only way to ensure that both
> author and committer identity information has the same timestamp
> is to omit `author` (thus copying from `committer`) or to use a
> date format other than `now`.

See?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

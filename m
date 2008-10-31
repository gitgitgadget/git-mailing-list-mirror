From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 14:58:57 -0700
Message-ID: <20081031215857.GZ14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <20081031184154.GV14786@spearce.org> <7vfxmc8r8g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:00:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw22N-0006mh-Kj
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbYJaV67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbYJaV67
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:58:59 -0400
Received: from george.spearce.org ([209.20.77.23]:56205 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYJaV66 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:58:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 798893835F; Fri, 31 Oct 2008 21:58:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vfxmc8r8g.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99654>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >>   * proper public "stuff" naming (I e.g. realy like types names -- not
> >>     struct or enum tags, that I don't really care -- ending with _t as
> >>     it helps navigating source.
> >
> > Fixed, types now end in _t.
> 
> Ugh.
> 
> You could talk me into it if you promise never typedef structures (or
> pointer to structures) with such symbols, I guess.
 
I should write that one down in CONVENTIONS.

IMHO:

  typedef uint32_t uid_t;       /* sane */
  typedef enum {...} status_t;  /* sane */
  typedef struct foo_t foo_t;   /* sane */

  typedef struct {...} foo_t;   /* borderline insane */

  typedef char* str_t;          /* totally nuts */
  typedef char**** str_pppp_t;  /* totally nuts */

Hiding the fact that scalar types like a uid_t are 32 bits on
this system is reasonable.  Heck, uid_t is already in POSIX,
we shouldn't fight that sort of idea.  It at least improves
documentation somewhat.

Hiding the fact that some scalar type is an enum, so you don't have
to type "enum blah" everywhere is also reasonable.  Its slightly
better than #define some magic constants and passing an int
everywhere.  Its a reasonable balance between reducing keystrokes
and keeping the code semi-self-documenting.

Hiding the fact that an opaque struct (or union) you cannot ever
see the members of is a struct or union is good API design.  You can
later change the major class from struct to union or back, or totally
redefine it, but the caller never needs to know what is going on.

Hiding a pointer is wrong.  Callers should know they are getting a
pointer, or are being asked to supply a pointer-to-a-pointer.  So the
"FILE*" stdio functions are sane, because we don't know what is under
a FILE type but we do know when we are dealing with a pointer to one.


My original proposal didn't stick _t onto the end of everything,
because I didn't think it was really necessary.  I'm fine with it
either way.  It may be better to include the _t suffix, it seems
to be somewhat common in libraries.

-- 
Shawn.

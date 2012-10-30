From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v5 1/3] completion: add new __gitcompadd helper
Date: Wed, 31 Oct 2012 00:18:32 +0100
Message-ID: <20121030231832.GB15709@goldbirke>
References: <1350229971-9343-1-git-send-email-felipe.contreras@gmail.com>
 <1350229971-9343-2-git-send-email-felipe.contreras@gmail.com>
 <20121017172808.GD2156@goldbirke>
 <CAMP44s3guAhFe1ACrAzC9T05fCMAejU6Wn+GtYfSpmfJ8EX-xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 00:18:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTL56-0003OR-TB
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 00:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab2J3XSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Oct 2012 19:18:36 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:61952 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab2J3XSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 19:18:35 -0400
Received: from localhost6.localdomain6 (p5B130686.dip0.t-ipconnect.de [91.19.6.134])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MPrBi-1TPVb11Jic-004dHh; Wed, 31 Oct 2012 00:18:33 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s3guAhFe1ACrAzC9T05fCMAejU6Wn+GtYfSpmfJ8EX-xg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:4b2uMHI/PL4mH9xXo+0LMOYnSNgMYI4xS8dx885XbWm
 mmYnROs55iDy1xxe2CKySQ++AddiR5Bvwv+2mJUzRdPQAky1kn
 QAU0qb3YKobdzZVuOOZGTafTxqD95iSELZiKy+qduacqg+29p+
 GDouDYw5206TJVmkDe27pXGR4E/eR7uuHgwxBKEOdnLxP/iSXa
 qKfjbFnqHyAgkn3ibzD2GTkXIWFwKPlVSUR804YKGZcfxFOyDb
 Pqt7LUBcN4/a0oARkXjeLAy4pPhQ+fF0hbodGav+RQjEX7o4uV
 8iim/QMbWmBZV/rylBIeXVVEHdx5rWQ0sthIL/BT+yJPw1dz4n
 Tl0Zt1n2PQb/r+DZkK1Zex2plvwP0xRfIBOYp03zG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208769>

On Mon, Oct 22, 2012 at 02:41:21AM +0200, Felipe Contreras wrote:
> On Wed, Oct 17, 2012 at 7:28 PM, SZEDER G=E1bor <szeder@ira.uka.de> w=
rote:
> > On Sun, Oct 14, 2012 at 05:52:49PM +0200, Felipe Contreras wrote:
>=20
> >> diff --git a/contrib/completion/git-completion.bash b/contrib/comp=
letion/git-completion.bash
> >> index d743e56..01325de 100644
> >> --- a/contrib/completion/git-completion.bash
> >> +++ b/contrib/completion/git-completion.bash
> >> @@ -225,6 +225,11 @@ _get_comp_words_by_ref ()
> >>  fi
> >>  fi
> >>
> >> +__gitcompadd ()
> >> +{
> >> +     COMPREPLY=3D($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
> >> +}
> >> +
> >>  # Generates completion reply with compgen, appending a space to p=
ossible
> >>  # completion words, if necessary.
> >>  # It accepts 1 to 4 arguments:
> >> @@ -238,13 +243,11 @@ __gitcomp ()
> >>
> >>       case "$cur_" in
> >>       --*=3D)
> >> -             COMPREPLY=3D()
> >> +             __gitcompadd
> >>               ;;
> >>       *)
> >>               local IFS=3D$'\n'
> >> -             COMPREPLY=3D($(compgen -P "${2-}" \
> >> -                     -W "$(__gitcomp_1 "${1-}" "${4-}")" \
> >> -                     -- "$cur_"))
> >> +             __gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}=
" "$cur_" ""
> >>               ;;
> >>       esac
> >>  }
> >> @@ -261,7 +264,7 @@ __gitcomp ()
> >>  __gitcomp_nl ()
> >>  {
> >>       local IFS=3D$'\n'
> >> -     COMPREPLY=3D($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${=
3-$cur}"))
> >> +     __gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
> >>  }
> >
> > I feel hesitant about this change.  One of the ways I'm exploring t=
o
> > fix the issues with shell metacharacters and expansion in compgen i=
s
> > to actually replace compgen.  We already iterate over all possible
> > completion words in __gitcomp_1(), so it doesn't make much of a
> > difference to do the filtering for the current word while we are at
> > it.  However, the way __gitcompadd() encapsulates COMPREPLY=3D($(co=
mpgen
> > ...)), and tha basic idea of never touching COMPREPLY directly make
> > this basically impossible.
>=20
> How is it impossible? You can still replace compgen, all you have to
> do is modify __gitcompadd and replace that code with whatever custom
> code you want. You can change the arguments and everything. The only
> limitation is that it should be the only place where COMPREPLY is
> modified, and all is good. Well, it doesn't have to be only _one_
> place, but the less functions that do this, the better.

That's exactly the problem: there isn't, there can't be one single
"whatever custom code I want".

The compgen() in __gitcomp() will be replaced by an enhanced version
of the loop in __gitcomp_1(), while in __gitcomp_nl() it will be
replaced by a little awk scriptlet.  And then there is the oddball
$(git ls-tree |sed magic) in __git_complete_revlist_file(), where
possible completion words are filenames possibly containing newlines,
therefore requiring yet another approach.

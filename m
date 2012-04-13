From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 11:45:00 +0200
Message-ID: <20120413094500.GD2164@goldbirke>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<20120413091236.GC2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 11:45:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SId48-0007nl-AR
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 11:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934481Ab2DMJpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 05:45:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:56407 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932961Ab2DMJpH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 05:45:07 -0400
Received: from localhost6.localdomain6 (p5B130584.dip0.t-ipconnect.de [91.19.5.132])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LiYwK-1RkOhc2aT6-00cX07; Fri, 13 Apr 2012 11:45:01 +0200
Content-Disposition: inline
In-Reply-To: <20120413091236.GC2164@goldbirke>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:iiiZ5Rl4I4t+4HD/Cy/+RON7pkoyZF0yJ3pjFYHjPyN
 Z1aKbnv/Z46n1N+CeNWDEu4uMB3td0XplcnQ1ny7Vf+Cb0H18M
 o/RDjEcRqt11VNfOKFJ9MPWxB8GXDxSh96B4jxH2nYy7CtSg+d
 VD/VVLg8WZmyghoFlX9p9dlfL8vAn+XxjLwv1sa+xxFVLlUX9l
 FuzX4UEK7Ncb6bhSTXLUP4TbEASSOht/pnaGD7ZdN+rHxo+YIx
 HHL2D5wV6JIKDwRIuOkSxauJ4C1BTUyR97XnOwZofce0A0p2cO
 prBZIJe6EGxo4Usy/eqBy03zkD5K/qHhB7DQrt9s02HHSAMPo4
 UsHOMq5j3PvAVWlYmuC4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195406>

On Fri, Apr 13, 2012 at 11:12:36AM +0200, SZEDER G=E1bor wrote:
> On Thu, Apr 12, 2012 at 12:57:03AM +0300, Felipe Contreras wrote:
> > +. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash"
> > +
> > +_get_comp_words_by_ref ()
> > +{
> > +	while [ $# -gt 0 ]; do
> > +		case "$1" in
> > +		cur)
> > +			cur=3D${_words[_cword]}
> > +			;;
> > +		prev)
> > +			prev=3D${_words[_cword-1]}
> > +			;;
> > +		words)
> > +			words=3D("${_words[@]}")
> > +			;;
> > +		cword)
> > +			cword=3D$_cword
> > +			;;
> > +		esac
> > +		shift
> > +	done
> > +}
>=20
> Git's completion script already implements this function.  Why
> override it here?

Ah, ok, I think I got it.

Of course, the words on the command line must be specified somehow to
test completion functions.  But the two implementations of
_get_comp_words_by_ref() for bash and zsh in the completion script
take the words on the command line from different variables, so we
need a common implementation to test completion functions both on bash
and zsh.  Hence the _get_comp_words_by_ref() above, which takes the
words on the command line and their count from $_words and $_cword,
respectively, and run_completion() below, which fills those variables
with its arguments.


> > +print_comp ()
> > +{
> > +	local IFS=3D$'\n'
> > +	echo "${COMPREPLY[*]}" > out
> > +}
> > +
> > +run_completion ()
> > +{
> > +	local -a COMPREPLY _words
> > +	local _cword
> > +	_words=3D( $1 )
> > +	(( _cword =3D ${#_words[@]} - 1 ))
> > +	_git && print_comp
> > +}

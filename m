From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 2/1] bash: eliminate dependency on bash_completion lib
Date: Thu, 2 Dec 2010 15:02:07 -0600
Message-ID: <20101202210207.GA4994@burratino>
References: <1291236582-28603-1-git-send-email-peter@avirtualhome.com>
 <20101202091624.GB1771@burratino>
 <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: Peter van der Does <peter@avirtualhome.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 22:02:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POGIc-0000nb-O1
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 22:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989Ab0LBVC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 16:02:27 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64359 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757902Ab0LBVC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 16:02:26 -0500
Received: by vws16 with SMTP id 16so1370156vws.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 13:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ARK8kuDfMAbtg6y4XMwy6X7Q1CJ/nwN04+3BcmRMSvg=;
        b=fZO/Sxa9hLeELrShXuG5wj9YxHFMhGEE/AFGQaRJOQ4kLY5DJjmPsB5hrpO3zG2oqE
         XKlmw8SXmBVz6c/3gbEi2FRAliXZlv9/snuBHnxZmeIRIAnWScSgCxexqN+ZWg4HPZ9x
         W8CDyXHRo6nK65hr2SZOw7P1eRmr4wo0qiHhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rJNxo5ZoeTzgyAtKGbzEnmD+lFJwXkq2qsOwr9qrWlh/0RXYoq9AeMjjDTRG1jEiCm
         YIPKsZjdmaS8GCdt05Y+AnhTyRqYXXU3xAt8bOTdpRiLLw52M98R6PNx8m2sjDDBxLHa
         Q/4NLW8o0Ohg3guAAwStBWXcpcDGluzhUswnI=
Received: by 10.220.91.206 with SMTP id o14mr164900vcm.113.1291323744725;
        Thu, 02 Dec 2010 13:02:24 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id p30sm162291vcf.26.2010.12.02.13.02.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 13:02:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101202091613.6ac8f816@MonteCarlo.grandprix.int>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162745>

Add a minimal implementation of _get_comp_words_by_ref,
the routine used to work around bash 4.0's COMP_WORDS semantics.

Based on bash-completion 2.x (commit bf763033, 2010-10-26) but
tweaked for simplicity and to allow zsh to at least parse the
code.

Based-on-patch-by: Peter van der Does <peter@avirtualhome.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Peter van der Does wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:

>>  2. Import the definition of _get_comp_words_by_ref from the
>>     bash-completion lib and use it if ZSH_VERSION is unset.
>>=20
>>  3. Further refinements, if needed.
>>=20
>> What do you think?
>
> I like the idea and we should go with this solution.
>=20
> If by importing you mean using :
> [CODE]. /git_bash_completion-functions[/CODE] in the
> contrib/completion/git-completion.bash script, which would be the bes=
t
> solution imho. The question is where to place that the function file.
[...]
> It would have to include copying the functions file somewhere as well=
=2E
>=20
> Or we could use the method used now and include the functions in the
> git-completion.bash script.

Sorry for the lack of clarity.  Here's what I meant.

 contrib/completion/git-completion.bash |  125 ++++++++++++++++++++++++=
++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 0b0eb45..1743319 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -327,7 +327,102 @@ __gitcomp_1 ()
 	done
 }
=20
+# The following function is based on code from:
+#
+#   bash_completion - programmable completion functions for bash 3.2+
+#
+#   Copyright =C2=A9 2006-2008, Ian Macdonald <ian@caliban.org>
+#             =C2=A9 2009-2010, Bash Completion Maintainers
+#                     <bash-completion-devel@lists.alioth.debian.org>
+#
+#   This program is free software; you can redistribute it and/or modi=
fy
+#   it under the terms of the GNU General Public License as published =
by
+#   the Free Software Foundation; either version 2, or (at your option=
)
+#   any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#   GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program; if not, write to the Free Software Founda=
tion,
+#   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+#
+#   The latest version of this software can be obtained here:
+#
+#   http://bash-completion.alioth.debian.org/
+#
+#   RELEASE: 2.x
+
+# This function can be used to access a tokenized list of words
+# on the command line:
+#
+#	__reassemble_comp_words_by_ref '=3D:'
+#	if test "${words_[cword_-1]}" =3D -w
+#	then
+#		...
+#	fi
+#
+# The argument should be a collection of characters from the list of
+# word completion separators (COMP_WORDBREAKS) to treat as ordinary
+# characters.
+#
+# This is roughly equivalent to locally setting COMP_WORDBREAKS to
+# exclude those characters, but it does not clobber COMP_WORDBREAKS.
+# The intent is for it to be used by commands like ssh that want to
+# treat host:path as one token.
+#
+# Output: words_, cword_, cur_.
+
+__git_reassemble_comp_words_by_ref()
+{
+	local exclude i j first
+	# Which word separators to exclude?
+	exclude=3D"${1//[^$COMP_WORDBREAKS]}"
+	cword_=3D$COMP_CWORD
+	if [ -z "$exclude" ]; then
+		words_=3D("${COMP_WORDS[@]}")
+		return
+	fi
+	# List of word completion separators has shrunk;
+	# re-assemble words to complete.
+	for ((i=3D0, j=3D0; i < ${#COMP_WORDS[@]}; i++, j++)); do
+		# Append each nonempty word consisting of just
+		# word separator characters to the current word.
+		first=3Dt
+		while
+			[ $i -gt 0 ] &&
+			[ -n "${COMP_WORDS[$i]}" ] &&
+			# word consists of excluded word separators
+			[ "${COMP_WORDS[$i]//[^$exclude]}" =3D "${COMP_WORDS[$i]}" ]
+		do
+			# Attach to the previous token,
+			# unless the previous token is the command name.
+			if [ $j -ge 2 ] && [ -n "$first" ]; then
+				((j--))
+			fi
+			first=3D
+			words_[$j]=3D${words_[j]}${COMP_WORDS[i]}
+			if [ $i =3D $COMP_CWORD ]; then
+				cword_=3D$j
+			fi
+			if (($i < ${#COMP_WORDS[@]} - 1)); then
+				((i++))
+			else
+				# Done.
+				return
+			fi
+		done
+		words_[$j]=3D${words_[j]}${COMP_WORDS[i]}
+		if [ $i =3D $COMP_CWORD ]; then
+			cword_=3D$j
+		fi
+	done
+}
+
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
+if [[ -n $ZSH_VERSION ]]; then
 _get_comp_words_by_ref ()
 {
 	while [ $# -gt 0 ]; do
@@ -352,6 +447,36 @@ _get_comp_words_by_ref ()
 		shift
 	done
 }
+else
+_get_comp_words_by_ref ()
+{
+	local exclude cur_ cword_
+	local words_=3D()
+	if [ "$1" =3D "-n" ]; then
+		exclude=3D$2
+		shift 2
+	fi
+	__git_reassemble_comp_words_by_ref "$exclude"
+	cur_=3D${words_[cword_]}
+	while [ $# -gt 0 ]; do
+		case "$1" in
+		cur)
+			cur=3D$cur_
+			;;
+		prev)
+			prev=3D${words_[$cword_-1]}
+			;;
+		words)
+			words=3D("${words_[@]}")
+			;;
+		cword)
+			cword=3D$cword_
+			;;
+		esac
+		shift
+	done
+}
+fi
 fi
=20
 # __gitcomp accepts 1, 2, 3, or 4 arguments
--=20
1.7.2.3

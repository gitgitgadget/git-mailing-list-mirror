From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v7 4/4] git-rebase: add keep_empty flag
Date: Thu, 19 Apr 2012 14:19:22 +0200
Message-ID: <4F9002CA.6040302@in.waw.pl>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com> <1334776680-23460-1-git-send-email-nhorman@tuxdriver.com> <1334776680-23460-5-git-send-email-nhorman@tuxdriver.com> <4F8FE2CD.3070300@in.waw.pl> <873980q6vm.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 19 14:20:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKqLY-0002v8-Ft
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 14:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab2DSMTr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 08:19:47 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35157 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753809Ab2DSMTr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 08:19:47 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SKqKf-0004Ft-1i; Thu, 19 Apr 2012 14:19:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120324 Icedove/10.0.3
In-Reply-To: <873980q6vm.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195937>

On 04/19/2012 01:49 PM, Thomas Rast wrote:
> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>
>> On 04/18/2012 09:18 PM, Neil Horman wrote:
>>> Add a command line switch to git-rebase to allow a user the ability=
 to specify
>>> that they want to keep any commits in a series that are empty.
>>>
>>> When git-rebase's type is am, then this option will automatically k=
eep any
>>> commit that has a tree object identical to its parent.
>>>
>>> This patch changes the default behavior of interactive rebases as w=
ell.  With
>>> this patch, git-rebase -i will produce a revision set passed to
>>> git-revision-editor, in which empty commits are commented out.  Emp=
ty commits
>>> may be kept manually by uncommenting them.  If the new --keep-empty=
 option is
>>> used in an interactive rebase the empty commits will automatically =
all be
>>> uncommented in the editor.
>>>
>>> Signed-off-by: Neil Horman<nhorman@tuxdriver.com>
>>
>> Hi,
>> this one seems to breaks many tests when /bin/sh=3Ddash. (Both v6 in=
 pu
>> and this v7).
>
> Probably because of the strange return in this function:
>
>>> is_empty_commit() {
>>> 	tree=3D$(git rev-parse "$1"^{tree})
>>> 	ptree=3D$(git rev-parse "$1"^^{tree})
>>> 	return $(test "$tree" =3D "$ptree")
>>> }
>
> bash seems to pass on the exit status from $() to the caller, while d=
ash
> doesn't.  It seems bash is actually more correct here, because POSIX
> says about 'return [n]':
>
>      EXIT STATUS
>         The value of the special parameter '?' shall be set to n, an
>         unsigned decimal integer, or to the exit status of the last
>         command executed if n is not specified.
>
> Either way, it should simply be spelled as
>
> is_empty_commit() {
> 	tree=3D$(git rev-parse "$1"^{tree})
> 	ptree=3D$(git rev-parse "$1"^^{tree})
> 	test "$tree" =3D "$ptree"
> }
Yes, this change fixes the problem (all tests pass).

Thanks!

Zbyszek

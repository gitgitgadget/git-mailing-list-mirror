From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bpush: Pushing to a bundle
Date: Tue, 09 Dec 2008 09:32:18 -0800
Message-ID: <7voczl45lp.fsf@gitster.siamese.dyndns.org>
References: <adf1fd3d0812090149m158fcb9as15bacce58c61a1a3@mail.gmail.com>
 <alpine.DEB.1.00.0812091100470.2916@eeepc-johanness>
 <adf1fd3d0812090221t2264a4f9i87b5e23be897ee84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git list" <git@vger.kernel.org>
To: =?utf-8?Q?Santi_B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 18:34:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA6Sw-0002ww-1e
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 18:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbYLIRc2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2008 12:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbYLIRc2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 12:32:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbYLIRc1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2008 12:32:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 11F28187CA;
	Tue,  9 Dec 2008 12:32:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 00BCC187BE; Tue, 
 9 Dec 2008 12:32:20 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 58656598-C617-11DD-ACCD-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102642>

"Santi B=C3=A9jar" <santi@agolina.net> writes:

> I do not find convenient strictly incremental bundles, because then
> you (or the other people) needs to fetch every single bundle. What I
> do is add new objects until the bundle is too big and then create a
> bundle with a new base. This way you don't have to worry if the other
> person has applied the last bundle or not.

You both have good points.  I sort of tend to side with your argument f=
rom
convenience point of view, if only because that resembles the way how
people traditionally arrange incremental backups "a full dump on Sunday
night, and every day incremental relative to the last full dump".  Dsch=
o's
suggestion is akin to "a full dump on Sunday night, and every day
incremental relative to the previous day".  Both form obviously can
recreate the same contents, but often "incremental since the last full
synchronization point", even though it may make bigger dumps, is easier=
 to
handle for humans.

>>  IOW if you already have a bundle,
>> you want to create a new bundle that contains everything that is new=
, _in
>> addition_ to the existing bundle.
>
>>> while [ $# !=3D 0 ] ; do
>>
>> Heh, I did not realize just how _used_ I got to the conventions in G=
it's
>> shell programming, until I thought "Should this not use 'test' inste=
ad
>> of brackets?"

Now I see you are improving ;-)

>>> while [ $# !=3D 0 ] ; do
>>>     refs=3D"$refs$LF$1" && shift
>>> done
>>
>> That is equivalent to refs=3D"$*", no?
>
> Almost, IFS is set to line-feed so I needed to put $LF instead of spa=
ces.

If $IFS is set to LF, "$*" will be $1, $2, $3 concatenated with LF in
between.  The first character in $IFS is used for that purpose..

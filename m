From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-describe --long to output always the long
 format
Date: Mon, 25 Feb 2008 00:54:21 -0800
Message-ID: <7vbq65ju0y.fsf@gitster.siamese.dyndns.org>
References: <1203864412-27977-1-git-send-email-sbejar@gmail.com>
 <20080225023634.GK8410@spearce.org>
 <7vwsotpwbr.fsf@gitster.siamese.dyndns.org>
 <8aa486160802250034ncdf20b6s13856ca8612bc2ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:55:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTZ7C-0005Sa-Uw
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbYBYIyj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 03:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbYBYIyj
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:54:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbYBYIyi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 03:54:38 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8845F242E;
	Mon, 25 Feb 2008 03:54:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6C84E242B; Mon, 25 Feb 2008 03:54:29 -0500 (EST)
In-Reply-To: <8aa486160802250034ncdf20b6s13856ca8612bc2ea@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Mon, 25 Feb 2008 09:34:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75018>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> On Mon, Feb 25, 2008 at 4:08 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> ...
>>  > Is this really that useful?  Where is having the tag and the comm=
it
>>  > SHA-1 both useful?
>>
>>  I had the same question.  The only place that I find this could
>>  be useful is when you tag, build and install, and then find
>>  glitches before pushing the results out and rewind, rebuild and
>>  re-tag.  I unfortunately have this issue almost all the time.
>>
>>  But even then, I would probably not rely on this patch.
>
> This can be usefull when more than one person can make "official" tag=
s
> (or nobody), and then you have a uniqe idendifier with a descriptive
> name.

That's backwards.  If you want reliable unique identifier, you
would use 40-hexdigit.  If you want human readable, you would
use tags, and if you allow different people to distribute tags
with the same name that point at different things, _you_ have a
problem at higher level.

By the way, I think the naming "git describe" does is not quite
right.  The name of the tag _usually_ matches its path under
refs/tags/ by convention, but the code seems to trust the path
and does not seem to examine what the actual tag name in the
annotated tag is.

I think it should name commits based on the real tag name, at
least when it is only using annotated tags (i.e. the default
mode of operation).

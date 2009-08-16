From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git http-push and MKCOL error (22/409)
Date: Sun, 16 Aug 2009 12:34:25 -0700
Message-ID: <7veirb5z9a.fsf@alter.siamese.dyndns.org>
References: <200908161557.26962.thomas.schlichter@web.de>
 <be6fef0d0908160727r7dfa9b46l4d493e3954c21de3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Schlichter <thomas.schlichter@web.de>,
	willievu <willievu@dev.java.net>,
	Sean Davis <sdavis2@mail.nih.gov>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 21:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MclaT-0002Zz-KQ
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 21:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbZHPTef convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Aug 2009 15:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbZHPTee
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 15:34:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbZHPTeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 15:34:31 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E109FD46D;
	Sun, 16 Aug 2009 15:34:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0FD0D46C; Sun, 16 Aug
 2009 15:34:26 -0400 (EDT)
In-Reply-To: <be6fef0d0908160727r7dfa9b46l4d493e3954c21de3@mail.gmail.com>
 (Tay Ray Chuan's message of "Sun\, 16 Aug 2009 22\:27\:40 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2D000F6-8A9B-11DE-B3B2-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126069>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Sun, Aug 16, 2009 at 9:57 PM, Thomas
> Schlichter<thomas.schlichter@web.de> wrote:
>> Current "master" and "next" trees also have this problem. But as git=
 version
>> 1.6.4 does not have this problem, I was able to bisect it down to co=
mmit:
>>
>> =C2=A0 5424bc557fc6414660830b470dd45774b8f5f281
>> =C2=A0 http*: add helper methods for fetching objects (loose)
>
> Interesting. Please do provide:
>
>  -steps to reproduce,
>  -your server's access log.

The report said:

    MKCOL 98fd7fb8f32843c1bb40bd195a2f1cd6cab0751d failed, aborting (22=
/409)

As far as I can see you are trying (in http-push.c::start_mkcol()) to
create the two-hexdigit fan-out directory (i.e. "98" for this example);=
 it
is strange to see a request to create the full 40-hexdigit collection i=
n
the first place.

In another thread you responded to earlier:

    http://thread.gmane.org/gmane.comp.version-control.git/125933/focus=
=3D125972

the original report did not give the exact error message, but in that o=
ne,
instead of failing to create 40-hexdigit collection like this, I am
guessing that it fails with something like "MKCOL 'refs' failed".

So are these unrelated "breakages"[1]?

[Foornote]

*1* Not necessarily in the sense the client is broken but in the sense
that the server-client combination does not work for the reporter.

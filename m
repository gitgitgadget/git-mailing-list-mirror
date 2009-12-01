From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale 
 list
Date: Tue, 01 Dec 2009 09:20:22 -0800
Message-ID: <7v8wdm1ui1.fsf@alter.siamese.dyndns.org>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com> <7viqcrbl22.fsf@alter.siamese.dyndns.org> <36ca99e90911302249r5f77f031o73cc7bb13dc375cf@mail.gmail.com> <7vy6ln2llw.fsf@alter.siamese.dyndns.org> <36ca99e90912010132iee0d42fo933aeb12833ad1ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 18:20:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFWP5-0007Q9-A2
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 18:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbZLARUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 12:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbZLARUb
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 12:20:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbZLARUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 12:20:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EEA1A34DD;
	Tue,  1 Dec 2009 12:20:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qSYL6JRRJJRq
	9Os/53bN4usvyDc=; b=OqAACq/NUtKrrrQf3GFfHpCVe2ZEVqavq24eFXT0brmb
	6GIhqX7fRBi7udB5q6YhloZdVM254rHC1WsNvMN8wxSlML3g0tLqJ19F9Huh4oCv
	WtwGj7nMj2A+vx2SJpb59VnIUMKvzgmHxrzQtNKhaDYhXoE8b2cMd3eHRjGx9YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qeWQQs
	nXZ6iG2h3b4xL3oxuq39y8glXR74hvn64CmeQoObYacOaa7OsazPYg0DrQFdGURi
	zigik49opyWcxSoVQeRXppraOwIY0qlOlepTidoAOMutfj3Mvv0YbQtcsePpD77d
	4e7HKLJUw3CwdmsjportYj8Q/S1MzedxLnJYs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 000AFA34DC;
	Tue,  1 Dec 2009 12:20:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2EB8AA34DB; Tue,  1 Dec 2009
 12:20:24 -0500 (EST)
In-Reply-To: <36ca99e90912010132iee0d42fo933aeb12833ad1ad@mail.gmail.com>
 (Bert Wesarg's message of "Tue\, 1 Dec 2009 10\:32\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3A187B0-DE9D-11DE-BED7-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134232>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>> =C2=A0- The ref abbrev_branch() is called and the address of whose s=
ubstring is
>> =C2=A0 taken to be used as "name" in handle_one_branch() is refspec.=
src, but
>> =C2=A0 what goes to .util is refname that is refspec.dst---they are =
different
>> =C2=A0 strings and one is not a substring of the other.
> I don't see you point here.

Of course you don't ;-) because we were looking at different versions.

I wanted to apply the same fix to both maint and master.  For the code =
in
'master' your observation is 100% correct.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] sequencer: sequencer state is useless without todo
Date: Sun, 13 Nov 2011 12:50:49 -0800
Message-ID: <7v7h33oifq.fsf@alter.siamese.dyndns.org>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 21:53:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPh3E-0000J8-82
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 21:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab1KMUuw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 15:50:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab1KMUuv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 15:50:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9F9F52AA;
	Sun, 13 Nov 2011 15:50:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UU2EVSY79whM
	FijSv+0GWlNauiQ=; b=WCEmxT1/VE+qPJyRRX6kB+3NYzmSXIu55ewVEPjlWrdY
	XJLqcGzuga3nb11DNA1svI8gy9T+PBMCUSxTroCqGNpu2fPCM8bmR0DFJlGFh6zv
	DctBsm8w8GbMJO52/lLlv+N5KW8OkvREJy24+XYM562S0qYJeGo7CM2dbC3toGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qfilFG
	TPyJL83oAUpjmC2pNY7ESCo6cFlQ6/MCaY37jP7ygikdHZRw9gg0VpwdJq8241Vd
	sOxmMvyVg5EwZlQOkWC0RAtHDXNAbzlsaV8jMucJU/dodvzoKcZR5p9TbnDUWuSr
	Lh1a5jzubDv5FaRHJ7pau9PrHo8BPWJpxlQ9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E231C52A9;
	Sun, 13 Nov 2011 15:50:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A43C52A8; Sun, 13 Nov 2011
 15:50:50 -0500 (EST)
In-Reply-To: <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun, 13 Nov 2011 16:14:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B97DC04-0E39-11E1-BF0A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185348>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>> =C2=A0static int create_seq_dir(void)
>>> =C2=A0{
>>> + =C2=A0 =C2=A0 const char *todo_file =3D git_path(SEQ_TODO_FILE);
>>> =C2=A0 =C2=A0 =C2=A0 const char *seq_dir =3D git_path(SEQ_DIR);
>>
>> Scary idiom.
>
> What's scary about it?

The next person who copies and pastes this code to other codepaths with=
out
thinking that the return value of git_path() is ephemeral and may need =
to
be saved away depending on what goes between its assignment and its use=
=2E

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to ignore instead?
Date: Sun, 25 Oct 2015 09:58:56 -0700
Message-ID: <xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
	<CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
	<xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
	<CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
	<CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Oct 25 17:59:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqOdL-0002Rj-FQ
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 17:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbbJYQ67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 12:58:59 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751151AbbJYQ66 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 12:58:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB76A246E2;
	Sun, 25 Oct 2015 12:58:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1OStDdBo7FrmEZNBp9etbm/R9Xk=; b=gKqUD2
	YiHmqMpqajaX8zjbZw1kmTmjyHGD2vEQoCmt2nfvzhIykdkHqP9BP1APLzr1t+Ki
	lzqNP70xP3LlW84O94rengpMhCM1sverOZt1ep8Fp09yr98Brp3n/63pPquM0v8C
	buoLPQPdLqzmJE/TFLhlLwiITPqwAHEzYYemQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uRm92zlwrQR0asYevMmknAMVwvyBvaPV
	Uzv0JxGCp4FeoXboX1c/LUrA7J66thzCXZjEUNVH6uVeDa/xLXgV3gV/wPiegZ8l
	THUOxm19GI9MQGgN9iyj8kz1w9IkEseyMpSHi9P18Z8EGWqSPUSWNhApv784Ij9r
	4m5AQaxNPPk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E2869246E1;
	Sun, 25 Oct 2015 12:58:57 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 61F4E246E0;
	Sun, 25 Oct 2015 12:58:57 -0400 (EDT)
In-Reply-To: <CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
	(Noam Postavsky's message of "Sat, 24 Oct 2015 17:47:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE695D76-7B39-11E5-A512-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280160>

Noam Postavsky <npostavs@users.sourceforge.net> writes:

> On Tue, Oct 20, 2015 at 10:35 PM, Noam Postavsky
> <npostavs@users.sourceforge.net> wrote:
>> On Sun, Oct 18, 2015 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I cannot speak for the person who was primarily responsible for
>>> designing this behaviour, but I happen to agree with the current
>>> behaviour in the situation where it was designed to be used.  Upon
>>> the first use in your session, the "daemon" is auto-spawned, you can
>>> keep talking with that same instance during your session, and you do
>>> not have to do anything special to shut it down when you log out.
>>> Isn't that what happens here?
>>
>> After looking at this some more, I've discovered this is NOT what
>> actually happens here. If I "git push" from a shell and then log out
>> and log in again, another "git push" does NOT ask me for a password.
>> In other words, the daemon is NOT shut down automatically when I log
>> out. Given that, does it make sense to change the daemon to ignore
>> SIGHUP, or is there some way to change it so that it does exit on
>> logout?

I have a feeling that it would be moving in a wrong direction to
change the code to ignore HUP, as I do think "logout to shutdown"
would be the desired behaviour.  If you are not seeing that happen,
perhaps the first thing to do is to figure out why and fix the code
so that it happens?

I dunno.  I'll cc Peff so that he can take a look when he comes
back.

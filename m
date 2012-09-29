From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Option for git bisect run to automatically clean up
Date: Sat, 29 Sep 2012 12:24:04 -0700
Message-ID: <7v4nmgiqej.fsf@alter.siamese.dyndns.org>
References: <CAOMwXhN=SpwGPaSr1p8K_y4yinuWA0hhynwpqi=5+xT-ZMVbYQ@mail.gmail.com>
 <CAOMwXhOv7oGXhtWu0apmDD7x+Vnh0jkc2QrnSPmc-=KCQQ08Yg@mail.gmail.com>
 <CAP8UFD21eCSzjJ3a0SxPTzzi2z4KMFr=1xE3j8fPz38AJrrJTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Laszlo Papp <lpapp@kde.org>, Git List <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 21:24:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TI2eA-0002Vb-IR
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 21:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779Ab2I2TYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 15:24:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757644Ab2I2TYH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 15:24:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6FFB8160;
	Sat, 29 Sep 2012 15:24:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qsK3Jg/jG++d33xSshtEB/8Osno=; b=LsYaHY
	7sXGPJC4hfSnatO/3CiliNiJCZGTYmHniJuVecrq5wWmX04cfZnIsIYXjrrDQjP/
	7JgkmzJeZVu0kZZ7c2HF4msSxIjZH1TR7db8n2XHJtFRFxMiXQCBd4VvMQPAPbHZ
	g/pOEUvnFfEOINvGGX5ElqOvGiDXBgzpAzkqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DzQ/X9PUMKKZw+bjXKjtml3/lMINTXSy
	bRnq9IdH0BIRJiC+rxFMihMlyvfU/u9/BLUk+MO2VWrtfb/rhLM7ql6aekem6b3a
	T1x55Z/AfpYgy2wrPbfOxxkRJz5WmmfLotRPPtqQtV1FsADMuiH3zGElASnGy3e6
	HCbqtgrx5WI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C35FD815E;
	Sat, 29 Sep 2012 15:24:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 250C3815D; Sat, 29 Sep 2012
 15:24:06 -0400 (EDT)
In-Reply-To: <CAP8UFD21eCSzjJ3a0SxPTzzi2z4KMFr=1xE3j8fPz38AJrrJTQ@mail.gmail.com>
 (Christian Couder's message of "Sat, 29 Sep 2012 18:51:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C2873B0-0A6B-11E2-A53A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206657>

Christian Couder <christian.couder@gmail.com> writes:

> I understand that, but I wonder what we should do if some people
> need a "git reset --hard" and if some other people need other
> options than -dfx.
> We would need both a --reset and a --clean, or perhaps even a
> --reset[=(hard|mixed|soft|merge|keep) and a --clean[=<clean-opts>].

> And then what if people want to clean only a subdirectory and not
> everything?  And this does not take into account the fact that
> many people will/should clean using "make clean" or "make
> distclean" or "rake clean" or something like that, so that a
> --clean option will not help them.

In short, the users can do that easily in their "run" script, and
the definition of "clean-up" will be different depending on what the
"run" script does (it may do "make" in which case "make clean" may
be a way, it may do "git apply fixup.patch" in which case "git apply
-R fixup.patch" may be the way, etc.), so adding "--clean" does not
help the users.  Just make the "run" script clean after itself.

If that is the argument, I'd buy that.

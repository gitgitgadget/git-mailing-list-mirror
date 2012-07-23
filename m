From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g.
 ImageMagick's
Date: Mon, 23 Jul 2012 15:22:27 -0700
Message-ID: <7v629ejexo.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFB19.6010905@gmail.com> <7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
 <500DA7F3.3000403@gmail.com> <7v4noykxvm.fsf@alter.siamese.dyndns.org>
 <CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:22:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StR1Q-0007CM-BS
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 00:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798Ab2GWWWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 18:22:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59753 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754717Ab2GWWW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 18:22:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E2F361C5;
	Mon, 23 Jul 2012 18:22:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pkp13o43PcrQpKqpEZd1aaUQX4Q=; b=yLdAKw
	n+38VeH5ee2XV1+mR5Jnl04gD5fCrrCMnzosPMOxoxBEdx8jAPuUIgl5/vp/F464
	KvPFIK9HW5V0/2nH2yi9TZKqTcbRc3/SOb7wNlniStuhnfVJpHQvWi4wE4S4v+tY
	nhguRyfn6BwVKWSZ7j+V9utJmM2B4b9u6Np6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d1Sxf4QStHLapSvndmEh8J+d6thQ1WWq
	f0pac7tZG6sY8L+1BnKGxCbjA65kS2W87+zgM7iB0ZLf944Nt1yzCwkVRDujNwsZ
	+BxKDVY8DCRq50ubfFe89G53AaChQtJu/WRsI5CxLubklHgrDF2m4K+xWLk3lcmh
	6dzBYhgBs0A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CF0061C3;
	Mon, 23 Jul 2012 18:22:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD1BD61C2; Mon, 23 Jul 2012
 18:22:28 -0400 (EDT)
In-Reply-To: <CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
 (Sebastian Schuberth's message of "Mon, 23 Jul 2012 23:09:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E35E0190-D514-11E1-8B3D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201995>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Personally, I've valued the gain of
> the patch to not list araxis as an available diff tool by "git
> difftool --tool-help" when in fact just ImageMagick is in PATH higher
> than the loss to support araxis installations that are in a path not
> containung "araxis" but are in PATH.

I agree that running ImageMagick's compare by accident is one thing
we would want to avoid, but once the problem is diagnosed, it is
something the user can easily work around by futzing %PATH%, I
think.

On the other hand, if the user has bought and installed Araxis, but
we incorrectly identify it as unusable, the user has wasted good
money and there is no easy recourse as far as I can see in your
patch.  That is why I wanted to see a reasonable assurance.

If we limit the problem space by special casing Windows installation
(e.g. check "uname -s" or something), would it make the problem
easier to solve?  Perhaps it is much more likely that the path the
program is installed in can be safely identified with a call to
"type --path compare" (bash is the only shell shipped in msysgit,
isn't it?), and its output is likely to contain "/Program Files/Araxis/"
as a substring, or something?

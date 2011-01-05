From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --find-copies-harder finds fewer copies/renames than -C does
Date: Wed, 05 Jan 2011 10:59:10 -0800
Message-ID: <7voc7vch35.fsf@alter.siamese.dyndns.org>
References: <1jukub7.uehx43wxtij7M%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Wed Jan 05 19:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaYZx-00042i-WA
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 19:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab1AES7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 13:59:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab1AES7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 13:59:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7BDEC30D3;
	Wed,  5 Jan 2011 13:59:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hZ7530L+PgrUki0dF0qjvYnY8Zg=; b=w+p/Jg
	c7IbPrzFdudQnrUoba9vBHCRef2zVQ1zreoLXvgeFlYcpjMJR0TpKVpZmQti8zkn
	Xl0fm61vppxViAf/Le1zDS9h4EpmBL6ocEewQ2ORmYoFbzSdML6AjVamygub/AgT
	I6f1YP9RctuuvpzIlTklJsFF0y5HFE7QmaCzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HdKFuEsOphs97Le9XmIHvtGw6gAc+WHF
	CZb84A0jwW0pUvtOPo996HEWtAGo4B6LmRJierADYwv6g4jVZfIAcpv5WdiaGMo+
	6bXGIWkeizY+q/9TzY2TUPOeb0UGBIR90DLD8HpjrwWQKw308cpBV/bbDaySfq2N
	+OsLfSzmO4g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A4D930D2;
	Wed,  5 Jan 2011 13:59:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7441330D0; Wed,  5 Jan 2011
 13:59:50 -0500 (EST)
In-Reply-To: <1jukub7.uehx43wxtij7M%lists@haller-berlin.de> (Stefan Haller's
 message of "Wed\, 5 Jan 2011 18\:46\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAB85EFA-18FD-11E0-8364-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164584>

lists@haller-berlin.de (Stefan Haller) writes:

> The reason for this seems to be the condition
> "num_create * num_src > rename_limit * rename_limit" in diffcore_rename;
> --find-copies-harder exeeds the limit, so it turns off inexact rename
> dectection *completely*, while -C stays well below the limit.
>
> I had expected --find-copies-harder to still do inexact rename detection
> among the changed files in the commit in this case, and turn it off only
> for the unmodified files; I'm not familiar enough with the code to tell
> whether that would be easy to implement though.
>
> Any thoughts?

Two.  When you can spend unlimited amount of resources, it would feel more
intuitive if -C -C lifted rename-limit altogether.  On the other hand, in
a project where the difference does matter (i.e. you have far too many
candidate sources), it is likely that -C -C without rename limit would run
out of memory and not produce any result, so automatic lifting of rename
limit is unacceptable as the default.

Setting rename-limit to match the size of your environment (perhaps do
this once in the config) would make this a non-issue, so coming up with an
automated way to do so might be an interesting exercise.

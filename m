From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/38] pack v4: commit object encoding
Date: Fri, 06 Sep 2013 15:08:08 -0700
Message-ID: <xmqq61udwqlz.fsf@gitster.dls.corp.google.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
	<1378362001-1738-11-git-send-email-nico@fluxnic.net>
	<xmqqvc2ezbbi.fsf@gitster.dls.corp.google.com>
	<alpine.LFD.2.03.1309061720330.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 07 00:08:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI4Ch-0008Gl-F7
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 00:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab3IFWIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 18:08:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab3IFWIa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 18:08:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1AF93D365;
	Fri,  6 Sep 2013 22:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1zW0OGQEvuhBGU8O3zauSk/r0I8=; b=MlC2Mz
	0IvY1Umrfa2msLLpCR3QxZlqI/GPfI9HMU7UzumbefB4m3uh2UZ3ke8Qng8Qn6Ru
	Vtfxrpikrtk7DeBYigcTuokjbdcOfjIJo2cMWGQ6n+gttvVxUbTaL9SAdPbPq6Lu
	XFLJOYT7Jg7CBv82JJyq1haD7JbkcC0OssE7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YOK+LLQtXWJgRzKr9ulLZjYb1Gl2VreR
	H5JGfYPVkDdw/58MV4thaGv708U6en6fFZfXGSZ/98C85w5EdKmjjFK2G68PTiJ2
	RT/x8ByIoreSdPKt8olfmz+px4wd12p23ALSV4MYAi8+NgA0ZPntzO7eXNgknhgW
	yYi87fH9IOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 338F33D363;
	Fri,  6 Sep 2013 22:08:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4074F3D351;
	Fri,  6 Sep 2013 22:08:26 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309061720330.20709@syhkavp.arg> (Nicolas
	Pitre's message of "Fri, 06 Sep 2013 17:28:04 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DA962F5A-1740-11E3-971E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234104>

Nicolas Pitre <nico@fluxnic.net> writes:

> OK.  If I understand correctly, the committer time stamp is more 
> important than the author's, right?

Yeah, it matters a lot more when doing timestamp based traversal
without the reachability bitmaps.

> ... may I suggest keeping the tree reference first.  That 
> is easy to skip over if you don't need it,...
> ... Whereas, for a checkout where only the tree info is needed, if it is 
> located after the list of parents, then the above needs to be done for 
> all those parents and the committer time.

Hmm.  I wonder if that is a really good trade-off.

"checkout" is to parse a single commit object and grab the "tree"
field, while "log" is to parse millions of commit objects to grab
their "parents" and "committer timestamp" fields ("log path/spec"
needs to grab "tree", too, so that does not make "tree" extremely
uncommon compared to the other two fields, though).

I dunno.

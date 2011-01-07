From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9010: svnadmin can fail even if available
Date: Fri, 07 Jan 2011 10:54:18 -0800
Message-ID: <7vfwt47det.fsf@alter.siamese.dyndns.org>
References: <4D25E818.5050909@gmail.com> <20110106165958.GA11190@burratino>
 <4D25F9C5.6030503@gmail.com> <20110106180051.GC11346@burratino>
 <7vpqs9aiul.fsf@alter.siamese.dyndns.org> <20110106204605.GA15090@burratino>
 <7vpqs98qti.fsf@alter.siamese.dyndns.org> <20110107013159.GA23280@burratino>
 <20110107165837.GA8062@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:54:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHSP-0004Tu-1A
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab1AGSyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:54:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab1AGSya (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:54:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 356782E8E;
	Fri,  7 Jan 2011 13:55:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=/+O5l0zfzykSt0cuX+6n+jm66SA=; b=JrJNyv
	dmN/vxpkaMImjpL+5Qqd550jAyqLKnNr7zfT2X9ReUV2TLUZm+6Ov54tMB5BZYQT
	+lEoKjTOTe1lYbn7gjUawXtC3QwX+4PdYFvI7H2BZuX4x5bkWe6CupjuR/P8euOJ
	bxgaP/cFLf9dE2U3Z18CT/2KikbQuQrvm1E3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UUizrkd2Ep5pJ1Ld+6hqh5ht8Nm3XmFJ
	ooJQdA2pm7N38DE+0vGx8lO/untTpfQMDWsIDnxTVI31vuWbzYb7sCvFNRuFfNZx
	X6r2uIa5QvwDrdNggmfoINorhOBkWfBFr7DAXc1S9EeDe/3mJxqZg7pqewlR9U5q
	e8I94SXWuQI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D34682E8D;
	Fri,  7 Jan 2011 13:55:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 76F152E8B; Fri,  7 Jan 2011
 13:54:59 -0500 (EST)
In-Reply-To: <20110107165837.GA8062@kytes> (Ramkumar Ramachandra's message of
 "Fri\, 7 Jan 2011 22\:28\:40 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3960576-1A8F-11E0-8AC2-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164741>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Jonathan Nieder writes:
>> To do the same for t91* would be impossible.  If svn is broken or not
>> installed, svn-fe will run fine, but "git svn" will not.  On the other
>> hand, if svnadmin were broken but svn still worked, "git svn" would be
>> fine but that would be quite strange and I do not think it is worth
>> spending time to prepare for.
>
> I don't think it's worth spending time preparing for every concievable
> breakage. The patch A few more examples of possible breakages I've
> encountered:
> - APR compiled without threading support, SVN compiled with it, or
>   viceversa.
> - SVN is compiled against GNU iconv, but apr-iconv installed, or
>   viceversa.
> - Two different versions of a dependent library are installed, and SVN
>   links to a different version in a different location.
>
> One or many components of SVN may fail. So, I'm in favor of the
> current approach: if SVN is installed, attempt to run all the t91*
> tests. Any failure can either be interpreted as a real test failure or
> malformed SVN installation.

That was what I was alluding to earlier, but ...

 (1) the patch has already been written and it looks obviously correct;

 (2) the code after the patch is shorter and more readable; and

 (3) this will prevent the mailing list from getting spammed by useless
     "bug reports" that should have been directed to distros that packaged
     subversion in one broken way.

Admittedly, it may only catch a breakage in one particular way and not
other ways, so we cannot put too much weight on (3), but I would say (2)
above alone is a merit enough for us to have this.

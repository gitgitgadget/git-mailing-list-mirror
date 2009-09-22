From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] Speed up fetch with large number of tags
Date: Tue, 22 Sep 2009 13:36:24 -0700
Message-ID: <7viqfapvhz.fsf@alter.siamese.dyndns.org>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
 <7vbplb2pi7.fsf@alter.siamese.dyndns.org>
 <20090916224651.GA15259@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 22 22:36:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqC6L-0003OY-9Z
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 22:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbZIVUgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 16:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbZIVUgc
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 16:36:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbZIVUgb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 16:36:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEA655B772;
	Tue, 22 Sep 2009 16:36:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CKDLZSnxNXnW2ODvUeu4Nhe23MY=; b=VyQi4c
	NrOAdSqNeAdQVlhA667CM+5OoXJdrLBFHFLDvkuaG9MY247hmafmeWLVS/epsot+
	V/BdSU0/aqAjZGlzThWj4MGSQkTXa77El4AUorAEexq8lm6If5/b856tx3KtMIYW
	iTeuAzfp7alzHetyKNL2tOPw0sHeh1KGRK4bA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wfyXom+yV8XojCEjW4h332PaWsWTLlgC
	XLjoB9iJZ7x5iz8KMVrX9O/dBNYE+oVaU8ssyqBwjlhsjCs0BoA7bUM0PQDy0eY4
	r1nxBsHL846OdXNmCwGLvS8hGNpzUtYOLr5lBK9Y8RbLhAE7F1jjndL5OtC/PRfC
	VNJ1uQ6sehw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79B005B770;
	Tue, 22 Sep 2009 16:36:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C77BC5B76F; Tue, 22 Sep 2009
 16:36:25 -0400 (EDT)
In-Reply-To: <20090916224651.GA15259@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 16 Sep 2009 15\:46\:51 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9C84B1B6-A7B7-11DE-9A94-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128957>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> A few questions (not criticisms).
>> 
>>  * 1m50s to 4.5s is quite impressive, even if it is only in a repository
>>    with unusual refs-vs-commits ratio, but I personally think 10 refs per
>>    every commit is already on the borderline of being insane, and the
>>    normal ratio would be more like 1 refs per every 10-20 commits.
>
> Under Gerrit Code Review it is normaly to have 2-5 refs per commit,
> every iteration of a patch is held as a commit and anchored by a
> unique ref.
>
> So we're borderline insane.  :-)

Heh, that's way below 10 refs per commit, isn't it?

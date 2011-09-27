From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Tue, 27 Sep 2011 09:56:52 -0700
Message-ID: <7vhb3xyld7.fsf@alter.siamese.dyndns.org>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
 <CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
 <20110925094822.GA1702@myhost>
 <CAMK1S_h3ufrK29_ajpcSSW7HV6ZA8z8ZVHvhHr2bx5Cga5FAKQ@mail.gmail.com>
 <7vwrcuzy44.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gR6U=OxzGsjTD8LbvZFS125=p1fQ8Af7aRD2XSsRur_Q@mail.gmail.com>
 <7voby6zwxg.fsf@alter.siamese.dyndns.org>
 <7vd3emzw8n.fsf@alter.siamese.dyndns.org> <20110927090225.GA1493@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 18:57:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8axq-0001fr-BC
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 18:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab1I0Q44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 12:56:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34358 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578Ab1I0Q4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 12:56:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA5B04873;
	Tue, 27 Sep 2011 12:56:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ulfKYEWgwgRj+Gud42rfH+XVu7k=; b=a3P8tW
	IA3tP4RgN2RM1qxhJyGfMoazptFTTv+g1v8Md4y72Kk/nheDTF2F7SoJw0Dz3Uhc
	P+OTKtSKM6J4SPdV5UvnC2tx07KZQfCbs8Mk2PwSD5UujWnGJTDzUn2OFwTAgRqc
	E2eLRB/JVNeOjskGkxAtelaEUS93srh2d/o1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P6c0T0GeRw2RbeNsTXN3u6T0yDHvOlF9
	Pji7F0B3k6127Jz7NtQxv42UIGAyZj8UvWeBvnuPKToU7jBF8ph/kr6UYnrHpBmC
	5VKIHn83E5izNeteODzQmPCyInowLIRLzRBntmNMA1++xu1sHKAw4vl3kAomQRf8
	CfMVtTz17+k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B17584872;
	Tue, 27 Sep 2011 12:56:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EB6A4871; Tue, 27 Sep 2011
 12:56:54 -0400 (EDT)
In-Reply-To: <20110927090225.GA1493@myhost> (Pang Yan Han's message of "Tue,
 27 Sep 2011 17:02:25 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B3EF432E-E929-11E0-B161-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182251>

[offtopic: where does that annoying M-F-T header come from? It even seems
to be pointless in this case as it lists the same people as are already on
To/Cc/From of the message.]

Pang Yan Han <pangyanhan@gmail.com> writes:

> Should I reroll this patch with this behaviour:
>
> - Everything as usual for valid ref updates and deletes
> - For deleting corrupt (dangling?) ref, post-receive and post-update hooks
>   also receive the same args as per valid update / delete

Suonds sensible.

> - For deleting non-existent refs:
>   - post-receive shall have empty stdin for those refs
>   - post-update shall have an empty arg for those refs

I do not think these hooks should see names of refs that ended up being a
no-op. If the push is only about attempting to delete a ref that did not
exist, these hooks should not even get called. If there were other refs
that got updated, these hooks have to be called, but they should not be
told about the no-op.  IOW

    $ git push $there :no-such-ref master:refs/remotes/origin/master

should:

 (1) not call the post-* hooks if the refs/remotes/origin/master was
     already pointing at the same commit; or

 (2) invoke the post-* hooks if refs/remotes/origin/master is updated, but
     should tell hooks only about the update of refs/remotes/origin/master.

That is pretty much in line with how a normal attempt to push the same
commit to an already up-to-date ref works.  For example, if you:

    $ git push $there master next

when 'master' is lagging and 'next' is already up-to-date, post-update and
post-receive hooks run and told only about 'master' and not 'next'.

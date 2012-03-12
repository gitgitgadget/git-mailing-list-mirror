From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Edit a rerere conflict resolution
Date: Mon, 12 Mar 2012 13:01:44 -0700
Message-ID: <7vobs1r3kn.fsf@alter.siamese.dyndns.org>
References: <4F5E4B20.5080709@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:01:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7BRL-00031K-K6
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976Ab2CLUBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 16:01:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756584Ab2CLUBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 16:01:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95E3064EF;
	Mon, 12 Mar 2012 16:01:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ArdDqJhXhrxuh0ISXApf8Ed+83Y=; b=h3jihc
	P36dtmlqfxtwHGCYX6z3FyNIZpF8VBQF6/P3rSX5PnDg6nTVjLPsmBOM0IyRp8G0
	36SnUer+H2z746tomA3JBSyhvXB/yvBLm5qvHCI68Y+2ws3Q1Y9TiS6r4Lt8KRL/
	xlY8fZqE2T3UU8EwNeDweB9/UTfd2IqVkmvo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lr5jcC8tJqQ8ob/5r7BuE/Tk57TxIylp
	30DUQ2UkLVnSPWzJBdE06WFub8xxh9weWMpfJuknN32MLXwnXWazqzu4koU2G/Lw
	nepiJscT8Gq/HDIKEO2IRdxdN13E59slSZVWJWvPMQOAqZaDdsCYAGJGTa3TPvtH
	RxTFLXjn6FA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D0CD64ED;
	Mon, 12 Mar 2012 16:01:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2370864EC; Mon, 12 Mar 2012
 16:01:49 -0400 (EDT)
In-Reply-To: <4F5E4B20.5080709@lyx.org> (Vincent van Ravesteijn's message of
 "Mon, 12 Mar 2012 20:14:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33FA7CB4-6C7E-11E1-BF7D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192935>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Would it be a useful addition to have a command 'git rerere edit
> <path> <commit>' ?
>
> This would allow the user to edit the conflict resolution which was
> used in a certain commit (merge, rebase.. ).
>
> Now I tend to grep in the .git/rr-cache directory, because I don't
> want to do 'git rerere forget' as this would require me to refix more
> resolution than needed.

I haven't find it necessary in practice, as the re-fix for me
typically would go like this:

    $ git merge other-branch
    ... rerere kicks in; eyeball the results
    ... ah, my earlier resolution is no longer correct
    $ edit $the_path
    ... test the result of manual edit in the context of the merged whole
    ... and be satisified
    $ git rerere forget $the_path
    $ git add $the_path
    $ git commit
    ... rerere records the updated resolution

What scenario do you have in mind that you would need to re-fix more
resolution than you need?

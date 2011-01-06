From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t0001,t1510,t3301: use sane_unset which always
 returns with status 0
Date: Thu, 06 Jan 2011 12:32:56 -0800
Message-ID: <7vlj2xai2v.fsf@alter.siamese.dyndns.org>
References: <gmeXEearzUOUEst4-B2b8sVUo0XhywYUDm7rCJikom1xi9tIroh9GnJRv-bJTzbCbvqI-4DOU3A@cipher.nrlssc.navy.mil> <gmeXEearzUOUEst4-B2b8nKnIcuDy8iOxR9s9wmOFYzBZT5rwFSFsnedLx8orqTDP1ztkJap7K8@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 06 21:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PawWK-0004yW-Qt
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 21:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab1AFUdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 15:33:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab1AFUdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 15:33:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E4692761;
	Thu,  6 Jan 2011 15:33:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+iGqdBywbUJm0hbeX4amwialUkM=; b=NrS2At
	yB6J7x4Key7foPmAzUMTUaJ/Dgv/SBPA96R66sSYzIHCfuwXur9BWRGq9VrfMepL
	eKGhE+MIUaapOmJsDZcFklrsZs8BrmP6mDgk80l3ecoaPDqMVkR7JXO3BPO/bg17
	kA/9cIlAu6bM0O3xwygC3yHE8hryO30M2if7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=REI2/93bkA3pZZ23Z6oKADRqmOjfWaMU
	rAUxHUGYmH9cDkjaqK10R0CKQ0JAm2se/tauS6hfQgweUa+K/0o9LsY1C4kaA1Ly
	YJv6oLk2gmSoOgj6bg7ZOgBNnoK8+evSGqkXI1LVfgQpIw6jF6ICyA+rYeJ69Vpw
	RAKaDs6mTsU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 60F4D275D;
	Thu,  6 Jan 2011 15:33:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B407275B; Thu,  6 Jan 2011
 15:33:35 -0500 (EST)
In-Reply-To: <gmeXEearzUOUEst4-B2b8nKnIcuDy8iOxR9s9wmOFYzBZT5rwFSFsnedLx8orqTDP1ztkJap7K8@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed\,  5 Jan 2011 18\:30\:02 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F1A5162-19D4-11E0-8341-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164668>

Thanks; there are a bit more from 

 $git grep -n -e '^[ 	]*unset[ 	].*&&' t

* t/t4150-am.sh:132:	unset test_tick &&

This should be safe, as we have already run test_tick to set it earlier.

* t/t5560-http-backend-noserver.sh:20:	unset REQUEST_METHOD &&
* t/t5560-http-backend-noserver.sh:33:	unset REQUEST_METHOD &&
* t/t5560-http-backend-noserver.sh:34:	unset CONTENT_TYPE &&

The varilable was earlier set inside the same function; safe.

* t/t5601-clone.sh:167:		unset GIT_CONFIG_NOGLOBAL &&

test-lib.sh sets this for us and this unsets it inside a subshell; safe.

* t/t6032-merge-large-rename.sh:98:	unset GIT_MERGE_VERBOSITY &&

test-lib.sh sets this for us and this unsets it; safe.

However, this unsets the variable permanently, damaging the environment
for tests other people later may add at the end of the script, which is
bad.  But that is outside the scope of your fix.

* t/t9130-git-svn-authors-file.sh:99:		unset GIT_CONFIG_NOGLOBAL &&
* t/t9130-git-svn-authors-file.sh:100:		unset GIT_DIR &&

test-lib.sh and then lib-git-svn.sh set these for us and this unsets them
inside a subshell; safe.

* t/t9130-git-svn-authors-file.sh:101:		unset GIT_CONFIG &&

As far as I can tell, this is unsafe; nobody has set GIT_CONFIG up to this
point.

* t/t9200-git-cvsexportcommit.sh:324:	 unset GIT_DIR &&

test-lib.sh sets this for us and this unsets it inside a subshell; safe.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Honor configure's htmldir switch
Date: Sat, 02 Feb 2013 19:31:15 -0800
Message-ID: <7vtxpu9ipo.fsf@alter.siamese.dyndns.org>
References: <20130202212504.GA16412@gmail.com>
 <7v7gmqb30p.fsf@alter.siamese.dyndns.org>
 <CA+7ShCrB_1Q=aKw5sP5hLkM1o0v-P1WR5+1iL983X7WQCHP=oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Thompson <cjsthompson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 04:31:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1qIv-000269-WD
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 04:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab3BCDbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 22:31:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639Ab3BCDbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 22:31:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46078B278;
	Sat,  2 Feb 2013 22:31:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Ox25CiReLjbfaNh6fpfQgB9WZQ=; b=HYZKoS
	2f9TPJTyt4YECuXbh0citS32/w/u6warA9Ozf/YdtTIdiOWRz8WXQjVAIvr4tuyw
	nckLw/uWkq5WrlrZFacg+RZYeAY1L5YjK1B66/9CousScZrQ0D0lPzlC1sy4Qdc2
	GT9JKn+cCIGrbACEDfeFpmtHKcOntv39mKoi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=adu8lE8l5bqkyjFPGS0ZU53hZR7rquhJ
	/ZK2QLuqa12mJgm4dS6wNjYEC2EulbDOB4BMBfyKXxBhBkd/jl6d43N2US28avHG
	CzZKX0leJ8CP74wuoD3X6Hb8FXXgYkGRUpjmAcmyW3W0XW+vEYLfMMkP2UcEecs/
	aSjWDWT5xnA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF50B276;
	Sat,  2 Feb 2013 22:31:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CC9BB270; Sat,  2 Feb 2013
 22:31:17 -0500 (EST)
In-Reply-To: <CA+7ShCrB_1Q=aKw5sP5hLkM1o0v-P1WR5+1iL983X7WQCHP=oQ@mail.gmail.com>
 (Christoph Thompson's message of "Sun, 3 Feb 2013 03:59:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B884274-6DB2-11E2-849C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215297>

Christoph Thompson <cjsthompson@gmail.com> writes:

> Will the --htmldir switch still work by exporting mandir and htmldir from
> the Makefile instead of
> config.mak.in ?

It should not make a difference where you export them from.  Lets
see...

-- cut here -- >8 -- cut here --

$ cat >Makefile <<\EOF
# The default target of this Makefile is ...
all:

var1 = one
var2 = two
var5 = five
var7 = seven
var8 = eight
include config.mak

export var2 var4 var8

all:
	env | grep '^var'

EOF
$ cat >config.mak <<\EOF
var3 = three
var4 = four
var6 = six
var7 = siete
var8 = ocho

export var1 var3 var7
EOF
$ make
env | grep '^var'
var1=one
var3=three
var2=two
var4=four
var7=siete
var8=ocho

-- cut here -- 8< -- cut here --

Everything behaves as I expect, I think.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] git-p4 tests: refactor, split out common functions
Date: Tue, 20 Sep 2011 19:34:29 -0700
Message-ID: <7vfwjq4o96.fsf@alter.siamese.dyndns.org>
References: <20110918012634.GA4578@arf.padd.com>
 <20110918012713.GA4619@arf.padd.com>
 <7v7h55cyis.fsf@alter.siamese.dyndns.org>
 <20110921012917.GA27256@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 04:34:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Ce2-0005fO-89
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 04:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab1IUCeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 22:34:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49902 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789Ab1IUCeg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 22:34:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC4F76BDB;
	Tue, 20 Sep 2011 22:34:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tjvb/rh+d1zo4fWPBvdYDccs6Hs=; b=vv/JCz
	b5HfIav6WXDlfZu/4Dk8eRalmUbooSxBlS7a1MZqgxYFDUcqhgdXuPGNBVJMZ1eU
	EKTzy+dGmwyfvKQEChjO3cd/sV07MLSM8Hf3RhoermwnKcGse76vBVRthwZ+bOfU
	vBBJGkPBVQu4xe+Vrmsfv//gLaBqwK00O2rmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yeqJHBHHNYEPIDa9p20/WutwUbkJ0izi
	cZRq+qq6caiannMUEW/muehD165fETN1OXDmam9eZG1k355B3rTS2l/sZOvWShk8
	ZiB41ZGBJe9rF9mExtT8hPvwOGuinUFO0yg1YCi4Gawxs6fkN8M+/b/GUY6f2Yks
	KvA94zhewUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2DE26BDA;
	Tue, 20 Sep 2011 22:34:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40F2A6BD9; Tue, 20 Sep 2011
 22:34:33 -0400 (EDT)
In-Reply-To: <20110921012917.GA27256@arf.padd.com> (Pete Wyckoff's message of
 "Tue, 20 Sep 2011 21:29:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D698982-E3FA-11E0-AB05-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181811>

Pete Wyckoff <pw@padd.com> writes:

> Yes, this is all very shoddy, and I suspect that I don't need the
> initial kill_p4d as long as the other tests fail nicely.
>
> But your point about killing the _wrong_ p4d is good.  But p4d
> isn't friendly like other daemons that will drop a pid file for
> help in future cleanup.  I can run it without the "-d", in which
> case it does not daemonize.  Then I should be able to use shell
> job control to kill off the one I started, hopefully.

Yeah, something like

	: start
	p4d &
        echo $! >$pidfile

        : stop
	while kill -0 $pidfile
        do
	        kill $pidfile
                sleep 1
	done

> Finding an unused port is also a pain.

I think the way t55xx series assign LIB_HTTPD_PORT is an acceptable
compromise.

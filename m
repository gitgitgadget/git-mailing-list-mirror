From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: deal with tag objects that do not have a
 tagger
Date: Thu, 18 Dec 2008 15:20:29 -0800
Message-ID: <7viqphf4ua.fsf@gitster.siamese.dyndns.org>
References: <20081218164614.GS5691@genesis.frugalware.org>
 <7vbpv9guqd.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0812182044100.6952@intel-tinevez-2-302>
 <20081218213407.GX5691@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, scott@canonical.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 00:22:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDSBr-0005br-6E
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 00:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbYLRXUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 18:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbYLRXUj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 18:20:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbYLRXUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 18:20:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D519887D8;
	Thu, 18 Dec 2008 18:20:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 39E18887D6; Thu,
 18 Dec 2008 18:20:32 -0500 (EST)
In-Reply-To: <20081218213407.GX5691@genesis.frugalware.org> (Miklos Vajna's
 message of "Thu, 18 Dec 2008 22:34:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A4E5F26-CD5A-11DD-80A0-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103507>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Thu, Dec 18, 2008 at 08:45:44PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> 	I think so.  The responsible code is in fast-export.c, in any 
>> 	case.  Of course, fast-import refuses to import a tag without a 
>> 	tagger, so...
>
> That's why I asked. I think it's a reasonable assumption that in most
> cases the tagger and the committer of the tagged commit is the same. So
> in case the tagger info is missing and we tag a commit, we could fake
> that info on export.
>
> Obviously this should not be the default, but I think such a mode would
> be useful in real-life.

Such a "faking" can well be done, and should be done, on the consuming end
of the information.  If you fake using the commit authorship, you would
never be able to tell from the result which one is faked and which one is
genuine.

I think you'd rather want to see "Unspecified Tagger" in the resulting tag
object (or even better, a tag object without the tagger field created by
the fast-import process), and leave the interpretation of missing tagger
information to the consumers.

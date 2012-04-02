From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Mon, 02 Apr 2012 11:25:33 -0700
Message-ID: <7v398mgfdu.fsf@alter.siamese.dyndns.org>
References: <7viphov839.fsf@alter.siamese.dyndns.org>
 <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
 <7viphotng8.fsf@alter.siamese.dyndns.org>
 <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
 <7v62dotltk.fsf@alter.siamese.dyndns.org>
 <20120329054558.GA27604@sigill.intra.peff.net>
 <CABPQNSY8gNPZTV77AjFbHn1HA9S=fw3NC+H8bCzZOPFyLg0nHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr, hellmuth@ira.uka.de
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 02 20:25:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SElwj-00075e-Gp
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 20:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268Ab2DBSZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 14:25:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39961 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751291Ab2DBSZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 14:25:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3372A71B8;
	Mon,  2 Apr 2012 14:25:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GlE1/g9RPDgbQsx6N4gVeJ58flw=; b=WcMUpE
	EqegpgmupF9rdaSlMUKGPYbxTjCjA7vsJw70l3g4FVLiVNLRSU8uspzgU/PR1p/M
	Hambwtmj0tK4FAclL5DFeBVfkDpId+QXzz2ab1tw12BvivfPpaDoTjEpGM+sVWSu
	TpupPgADd6RDiyoUkadrJZtmDU36iMRKn7q7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UEICPMEHet2dJXitOL4kzr7ysKBIZ6hZ
	if1vSOXOcNsR9F3k3EnJro9TvqGnvGfXWMh8gz96TGzWvVPWFkBh7WwSnkrxycC2
	8BWrO3bQoUzjoJ516VQ9BwlmJHzTpgJ+OEBmELnSgGB95BHKjjTBFXYw84r5V42w
	1kP2bVJVGmc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27BF771B7;
	Mon,  2 Apr 2012 14:25:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A046471B6; Mon,  2 Apr 2012
 14:25:34 -0400 (EDT)
In-Reply-To: <CABPQNSY8gNPZTV77AjFbHn1HA9S=fw3NC+H8bCzZOPFyLg0nHQ@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 2 Apr 2012 19:20:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CCA5CD2-7CF1-11E1-B53B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194546>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Thu, Mar 29, 2012 at 7:45 AM, Jeff King <peff@peff.net> wrote:
>>
>> I like that we are down to a single ls-files invocation here. But can't
>> we determine from the diff-files output whether an entry is unmerged. In
>> my simple tests, I see that --numstat will show two lines for such an
>> entry. Is that reliable?
>
> Nice. I've observed the same thing (although I've seen three entries,
> not two). I don't know about the reliability, but I think it kind of
> makes sense; one entry for both parents, and one for the unmerged
> working-copy version.

Should I be dissappointed, or should I be happy for seeing "division of
labor" working?

By default "diff-files" compares stage #2 with the working tree files, and
at the same time shows an unmerged record.  When there is no stage #2
entry, you will only see the unmerged record.

Notice that 1_3 is shown only once in the --numstat part of the output if
you run the script attached at the end.

I think the easiest thing to get the right information is to add --raw to
get the raw entries and read the status letters off of them.


-- >8 --
#!/bin/sh

mkdir -p /tmp/xprm && mkdir /tmp/xprm/stages && cd /tmp/xprm/stages || exit

git init

for i in 1 2 3
do
	echo "$i" | git hash-object -w --stdin
done
git update-index --index-info <<EOF
100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 1	123
100644 0cfbf08886fca9a91cb753ec8734c84fcbe52c9f 2	123
100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 3	123
100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 1	12_
100644 0cfbf08886fca9a91cb753ec8734c84fcbe52c9f 2	12_
100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 1	1_3
100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 3	1_3
100644 0cfbf08886fca9a91cb753ec8734c84fcbe52c9f 2	_23
100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 3	_23
EOF

git diff-files --numstat --summary --raw --abbrev=4

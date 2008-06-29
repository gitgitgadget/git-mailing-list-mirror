From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-merge to pass -X<option> to the backend
 strategy module
Date: Sun, 29 Jun 2008 12:09:01 -0700
Message-ID: <7v63rsawj6.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns. org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
 <7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
 <7vwsk8d3q5.fsf@gitster.siamese.dyndns.org> <g47oc3$q1l$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 21:10:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD2Hm-0006eb-VB
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 21:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161AbYF2TJL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 15:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756152AbYF2TJL
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 15:09:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126AbYF2TJK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jun 2008 15:09:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 362E616414;
	Sun, 29 Jun 2008 15:09:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0702416413; Sun, 29 Jun 2008 15:09:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D96873DA-460E-11DD-8435-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86820>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> diff --git a/git-merge.sh b/git-merge.sh
>> index 39b5cd9..d475852 100755
>> --- a/git-merge.sh
>> +++ b/git-merge.sh
>> @@ -17,6 +17,7 @@ commit =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 perform a commit if the merge succeeds (default)
>> =C2=A0ff =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 allow fast forward (default)
>> =C2=A0s,strategy=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0merge strategy=
 to use
>> =C2=A0m,message=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 message to be =
used for the merge commit (if any)
>> +X=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 pass merge strategy specific options
>> =C2=A0"
>
> You have updated usage for git-merge, but didn't update manpages
> (Documentation).

Patches welcome ;-)

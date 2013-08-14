From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 15:53:36 -0700
Message-ID: <7vd2pfsx3j.fsf@alter.siamese.dyndns.org>
References: <520BAF9F.70105@googlemail.com>
	<201308141125.59991.mfick@codeaurora.org>
	<520C01C3.2060804@googlemail.com>
	<201308141628.42163.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	iveqy@iveqy.com
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Aug 15 00:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9jwl-000625-MT
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 00:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933407Ab3HNWxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 18:53:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933149Ab3HNWxj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 18:53:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAEBC38316;
	Wed, 14 Aug 2013 22:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jqc2blbgs+ljHTDM5xQ4XcOUsZA=; b=jw+hd7
	+L0ojmUkSvbarcpB0FDbWsLA7Q92bMybP0ss+fAhy+3N196u1URGZITk6KlbPnQh
	sTlOORPtDL39g3EEuXGLmJ/xOwjHRLsfwJjf3ANGQ9zY1HDCnQ3810/UwIpw5uLo
	9VuL7Lma2CjyBsWfkdtqtmoylthUDtf3Ms2S0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rnfrGke6Ffv8CKBC7FcW2Yvq85QQHSZQ
	CgGQ8O7PnRZv8Ep82Ibckv5XnvWgWFEOFHcoMzaGn5qwv/NdJ4ji1uXRC+uBXudn
	wbgCkgfLcUcayaHem1ujQl/xrfgiOCrAiKxAOe5HcA3FakftYRqmLJDDwdwUSAx7
	qNchtrN/fBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D00CB38315;
	Wed, 14 Aug 2013 22:53:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3013E38313;
	Wed, 14 Aug 2013 22:53:38 +0000 (UTC)
In-Reply-To: <201308141628.42163.mfick@codeaurora.org> (Martin Fick's message
	of "Wed, 14 Aug 2013 16:28:41 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B74B8B8-0534-11E3-BF0D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232319>

Martin Fick <mfick@codeaurora.org> writes:

> One suggestion would be to change the repack code to create 
> pack filenames based on the sha1 of the contents of the pack 
> file instead of on the sha1 of the objects in the packfile.  
> ...
> I am not 100% sure if the change in naming convention I 
> propose wouldn't cause any problems?  But if others agree it 
> is a good idea, perhaps it is something a beginner could do?

I would not be surprised if that change breaks some other people's
reimplementation.  I know we do not validate the pack name with the
hash of the contents in the current code, but at the same time I do
remember that was one of the planned things to be done while I and
Linus were working on the original pack design, which was the last
task we did together before he retired from the maintainership of
this project.

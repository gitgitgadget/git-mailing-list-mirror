From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git.pm with recent File::Temp fail
Date: Mon, 29 Apr 2013 01:18:18 -0700
Message-ID: <7vd2tdn41h.fsf@alter.siamese.dyndns.org>
References: <20130322205758.09ca9107@pc09.procura.nl>
	<CAP30j14=_U8iEZAodnfACnBHgF0+j0_OK7n7PvsUnwSDj_Y40A@mail.gmail.com>
	<20130428110933.436786bd@pc09.procura.nl>
	<20130429021651.GA2751@sigill.intra.peff.net>
	<7vr4hung17.fsf@alter.siamese.dyndns.org>
	<20130429074620.17fbf129@pc09.procura.nl>
	<7vy5c1narj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Ben Walton <bdwalton@gmail.com>,
	git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Apr 29 10:18:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWjI3-00081v-DO
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 10:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756965Ab3D2ISW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 04:18:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59978 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284Ab3D2ISU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 04:18:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2670916F58;
	Mon, 29 Apr 2013 08:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KuKtOhh1z4Fw0VozExGG6ZuyEEY=; b=AqCC5w
	i4z/Ivhunq09KDSt+CzJdv3pOEw0NmnrsEaFITFWQ2cntAP62trXqpb7Rdgbz6ap
	w1r4y8D5nopIHWIrb++VFT2w7Q7FX6fclW0g2KiycNIXH5fk7SLZ0yG6skMhyjLA
	wOJMwqvnjwGiUBM8/UV+hFCNohrrzfDAHkjBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hccsxLbAyxqEQgTYde2rwE5iOz5jXn3I
	WOMT0uTGlMx397ASqyAuKH0pXDCwUs7QJmTqMNgSEAe6J3WwfG9H8gF/2R+B0zpJ
	dijkbvLJpCRf2dLkSY5MTMt0lf8ggm/M2T304Hp8r49AvPfuqsnRJxOzu9sAL+UH
	TJTQxfAQRPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E33E16F56;
	Mon, 29 Apr 2013 08:18:20 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80A1216F53;
	Mon, 29 Apr 2013 08:18:19 +0000 (UTC)
In-Reply-To: <7vy5c1narj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 28 Apr 2013 22:53:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59B0852C-B0A5-11E2-85F7-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222781>

Here is what I'll queue.

Thanks for the help, all of you.

-- >8 --
From: H. Merijn Brand <h.m.brand@xs4all.nl>
Subject: Git.pm: call tempfile from File::Temp as a regular function

We call File::Temp's "tempfile" function as a class method, but it was
never designed to be called this way. Older versions seemed to
tolerate it, but as of File::Temp 0.23, it blows up like this:

  $ git svn fetch
  'tempfile' can't be called as a method at .../Git.pm line 1117.

Fix it by calling it as a regular function, just inside the File::Temp
namespace.

Signed-off-by: H. Merijn Brand <h.m.brand@xs4all.nl>
Helped-by: Jeff King <peff@peff.net>
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 497f420..76383b9 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1039,7 +1039,7 @@ sub _temp_cache {
 			$tmpdir = $self->repo_path();
 		}
 
-		($$temp_fd, $fname) = File::Temp->tempfile(
+		($$temp_fd, $fname) = File::Temp::tempfile(
 			'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
 			) or throw Error::Simple("couldn't open new temp file");
 

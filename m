From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: overly smart rebase - bug or feature?
Date: Mon, 10 Nov 2008 18:31:25 -0500
Message-ID: <32541b130811101531r4b92edc3wfdfb49dc0e5119f4@mail.gmail.com>
References: <20081110212333.GU6799@sun.com>
	 <7vod0n41i5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Fedor Sergeev" <Fedor.Sergeev@sun.com>, Roman.Shaposhnick@sun.com,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:33:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgFO-0002rq-K1
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbYKJXb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbYKJXb1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:31:27 -0500
Received: from rn-out-0910.google.com ([64.233.170.184]:33414 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbYKJXb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:31:27 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1645505rnd.17
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 15:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bfuFonq63Ir03zAQYAyQaAMeKJku1EWOgot5Iy+exIs=;
        b=NgaffeC4GC0akmqTH7jiWbzMqwxl7OA+n7Z5eXGspahM9mVY9XdHXMa6MjihUQEnrk
         /W+Gy4peSjs1W5CE+xp0RydRq1z5pQAsBS57EdR8nNIWvjhcAcdb0V9Wf6lWZSNJX7JO
         mSn1qpknwdbr+xPtSWQDoKgPCFO3RwnkSy/EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OmVKR1xJQaAPas40IeU4zGRZ2/7k3Qki4U+kig5Q7F0PcMRsysEhk9y8kYbpdlkJsq
         aB54p2ZqzXPZNayZcDWwq5G1AMLog4Ey2H/uCqoyealAPP97cszvf0e6+ihT1YBTW8PM
         w1pL3Y4DCxel0uiLhGc0AdlZGdaeX5Erljfn4=
Received: by 10.151.150.20 with SMTP id c20mr10738116ybo.139.1226359885778;
        Mon, 10 Nov 2008 15:31:25 -0800 (PST)
Received: by 10.150.96.5 with HTTP; Mon, 10 Nov 2008 15:31:25 -0800 (PST)
In-Reply-To: <7vod0n41i5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100590>

On Mon, Nov 10, 2008 at 6:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When applying the change to Makefile, it notices that B does not have
> Makefile, but there is a path that is _identical_ to the preimage your
> change applies to (namely, Makefile2).  To support people who rename
> Makefile to Makefile2 in the history that led to B, rebase (actually the
> underlying "am -3" it calls is where this rename detection smart lies)
> applies the changes to the "renamed" path.

But isn't rename detection in this case rather suspicious, since:

- the preimage already had Makefile, Makefile1, and Makefile2, thus it
is not a rename, but at most a copy, and not even a newly-created copy
in either branch;

- *two* different files match the original Makefile, but rebase has
randomly selected one but not the other;

- (I haven't verified this claim) cherry-pick and merge both correctly
identify the problem as a delete/modify conflict?

It seems that rebase should have bailed out for at least one of these
three reasons.

Avery

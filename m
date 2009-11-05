From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of 
	Pthreads API
Date: Thu, 5 Nov 2009 09:51:22 +0100
Message-ID: <16cee31f0911050051m4cd29827nca9c8238b21461a0@mail.gmail.com>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
	 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
	 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
	 <4AF21283.3080407@gmail.com> <4AF214D5.6050202@gmail.com>
	 <alpine.LFD.2.00.0911041915120.10340@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 09:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5y42-00025p-Mi
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 09:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbZKEIvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 03:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbZKEIvT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 03:51:19 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54748 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbZKEIvS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2009 03:51:18 -0500
Received: by bwz27 with SMTP id 27so9819990bwz.21
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 00:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jzffKiVDTFW8CwxEPW+eDhZ/U0GZGJO7yytx9UEkFww=;
        b=U6UTYaVuqfzBp7fSj+KUlMDutUiajDTY2zYcq83GPj3YzwfFKS1Z19FcJu1hnNz3CO
         J1O2NX0LF0aumM8+I7FmUbeG3cC7nZJZSE2wb5opnJVf4QsjGNtKBEkYLQsB5kFheKZ/
         rV0OSWVIhwscSbjDQqPjaHXCCPKmIkBMHmbTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iysxAZKZ7rsj73Ho3ySm9Gb4d38G1N8/m/2MW+pqVvfYaSZw8fj7AMcVtN74ZfpLfi
         8OEAjsQlaQEuJWWFeipWN5+E6VG78j9tabo4/o1G+5xY0AX//0dGRpc5y6gzCJj08rdE
         Zq2mVfoHgN8gCxwk2k8TJeSRaEpHGB76SW53w=
Received: by 10.239.138.18 with SMTP id n18mr282404hbn.40.1257411082865; Thu, 
	05 Nov 2009 00:51:22 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911041915120.10340@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132215>

2009/11/5 Nicolas Pitre <nico@fluxnic.net>:
> Careful. =A0At the beginning of the function you'll find:
>
> =A0 =A0 =A0 =A0if (delta_search_threads <=3D 1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0find_deltas(list, &list_size, window, =
depth, processed);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> That is, if we have thread support compiled in but we're told to use
> only one thread, then the bulk of the work splitting is bypassed
> entirely. =A0Inside find_deltas() there will still be pthread_mutex_l=
ock()
> and pthread_mutex_unlock() calls even if no threads are spawned.

Ah, I wasn't aware of that. Actually why would find_deltas lock if no
threads are used? Maybe, for non-threaded call to find_deltas, locking
could be factored out?

--
Andrzej

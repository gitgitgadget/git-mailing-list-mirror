From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: gc does not clean up after itself when not enough disk space
Date: Wed, 27 Feb 2013 05:58:20 +0530
Message-ID: <CAMK1S_hxZZzi911s2QRpc67sNf_U7Ceo1fPT_hg1gO500pO=6A@mail.gmail.com>
References: <512CD689.4050705@gmail.com>
	<512CD703.4080302@gmail.com>
	<7v1uc3njnf.fsf@alter.siamese.dyndns.org>
	<512D1B8C.9070506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"jones.noamle" <lenoam@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 27 01:28:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAUtB-0005fK-Hx
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 01:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933443Ab3B0A20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 19:28:26 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:34741 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759651Ab3B0A2X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 19:28:23 -0500
Received: by mail-we0-f179.google.com with SMTP id p43so4040254wea.24
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 16:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vfKUd5p5Jc6sCCpkKuseDA06YUFn6mRwTAyJI7JPhPM=;
        b=uQ/y9gCSznyPoxQ/lCL7ee7Sk3FwhcSVzosk22DDdYyJO8S29MRju6xyg/A+XVEOSO
         N3OlWIiWKrl/UKGbeBkf+M7bmfpIGCWKKFGjppaZXipofAr6Vz7UcMCy+AezJRUNcTOS
         0PyqcOuizulDdpyuY5h84CeAOxdCGCR4gOQzUYyA88nX/C4jRzwksNfaYMniOHTBJNRg
         g+aCc6Pl6W2i4Z7jGPXwUSrqmLe10M6sMtRB6anOtWlrkI24xlDf5i1gQDgvP7Tn1Cfr
         Zk951gf1Rx/W3xUUs8ByLBjMF0XUOtILECJeCirqr3lHFhgkCV9dAD4AYT13kaS6dRty
         0dfw==
X-Received: by 10.194.156.196 with SMTP id wg4mr373387wjb.22.1361924901011;
 Tue, 26 Feb 2013 16:28:21 -0800 (PST)
Received: by 10.194.153.161 with HTTP; Tue, 26 Feb 2013 16:28:20 -0800 (PST)
In-Reply-To: <512D1B8C.9070506@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217191>

On Wed, Feb 27, 2013 at 2:01 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 26.02.2013 17:07, schrieb Junio C Hamano:
>> "jones.noamle" <lenoam@gmail.com> writes:
>>
>>> # git gc
>>> Counting objects: 44626, done.
>>> Delta compression using up to 8 threads.
>>> Compressing objects: 100% (7756/7756), done.
>>> fatal: sha1 file '.git/objects/pack/tmp_pack_uJ0E5b' write error: No
>>> space left on device
>>
>> In general when we encounter an unexpected error, we tend to try
>> leaving things as they are so that we can help diagnosing the
>> failure. But when you ran out of disk space I would agree that it
>> may be sensible to remove a temporary file we didn't manage to write
>> out in full.
>
> Ack. I just recently had to do
>
>    git gc || rm -f .git/objects/*/tmp_*
>
> as workaround in the nightly housekeeping script on our CI server.

it's not just 'git gc'; a failed push of a large repo (failed due to,
say, network issues or whatever) also leave tmp_* lying around.  At
least as far as I can tell...

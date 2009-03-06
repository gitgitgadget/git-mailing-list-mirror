From: Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] git-p4: improve performance with large files
Date: Thu, 5 Mar 2009 22:25:48 -0300
Message-ID: <1d48f7010903051725v510f99f0h2a05b9381ff75ac1@mail.gmail.com>
References: <20090304215438.GA12653@zoy.org>
	 <20090305100527.shmtfbdvk0ggsk4s@webmail.fussycoder.id.au>
	 <20090305172332.GF25693@zoy.org>
	 <7vzlfzwiyn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Simon Hausmann <simon@lst.de>, git@vger.kernel.org,
	Sam Hocevar <sam@zoy.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 02:27:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfOqw-0005zP-79
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 02:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbZCFBZz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 20:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbZCFBZz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 20:25:55 -0500
Received: from smtp-out.google.com ([216.239.45.13]:10003 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZCFBZy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 20:25:54 -0500
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id n261Po6c027192
	for <git@vger.kernel.org>; Thu, 5 Mar 2009 17:25:51 -0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1236302751; bh=VP+qJgZkPIvoQ1F80IJ8/sIG4nQ=;
	h=DomainKey-Signature:MIME-Version:In-Reply-To:References:Date:
	 Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-System-Of-Record; b=bdYxyD94iijtCDa+E4
	cenxU7yIedkwzWG4eM1FvpHJ5FcL6gdQG7keSohidgUXMrP78OEYQwEicu1uAy01t1M
	A==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to:
	cc:content-type:content-transfer-encoding:x-system-of-record;
	b=PJumQPfGaO8CjkK5wbOwpvvGwOp+RGsUH1rHfOa7Qf5ksMGhuw2V7aaALcsDkVxXC
	ePA84MoZlhV+8pPt+K40g==
Received: from qw-out-2122.google.com (qwe3.prod.google.com [10.241.194.3])
	by wpaz1.hot.corp.google.com with ESMTP id n261Pmvc025976
	for <git@vger.kernel.org>; Thu, 5 Mar 2009 17:25:49 -0800
Received: by qw-out-2122.google.com with SMTP id 3so192800qwe.23
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 17:25:48 -0800 (PST)
Received: by 10.229.86.149 with SMTP id s21mr1537015qcl.94.1236302748277; Thu, 
	05 Mar 2009 17:25:48 -0800 (PST)
In-Reply-To: <7vzlfzwiyn.fsf@gitster.siamese.dyndns.org>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112365>

I don't understand the point of trying to save the 32 mb, if people
are sending you blobs that are that large.

The approach to avoid sequences of appends looks sound.


On Thu, Mar 5, 2009 at 10:14 PM, Junio C Hamano <gitster@pobox.com> wro=
te:

>> ... The ideal solution is to use a generator and refactor the commit
>> handling as a stream. I am working on that but it involves deeper
>> changes, so as I am not sure it will be accepted, I'm providing the
>> attached compromise patch first. At least it solves the appaling spe=
ed
>> issue. I tuned it so that it never uses more than 32 MiB extra memor=
y.

>> + =A0 =A0 =A0 =A0 =A0 =A0text +=3D ''.join(data)
>> + =A0 =A0 =A0 =A0 =A0 =A0del data

i'd say

  data =3D []

add a comment that you're trying to save memory. There is no reason to
remove data from the namespace.

--=20
Han-Wen Nienhuys
Google Engineering Belo Horizonte
hanwen@google.com

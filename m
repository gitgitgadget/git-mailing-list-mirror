From: Shawn Pearce <spearce@spearce.org>
Subject: Re: push race
Date: Mon, 15 Oct 2012 19:09:52 -0700
Message-ID: <CAJo=hJu=eqgUhJvvpMLJ05AT6o+nVUDcm+tHV8en8OCX2-2qgA@mail.gmail.com>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com> <20121015185608.GC31658@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marcnarc@xiplink.com,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 04:10:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNwc2-00081O-JS
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 04:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab2JPCKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 22:10:16 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:52491 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab2JPCKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 22:10:15 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so1935035qad.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QSNhk30EuwGivRxCTaGf24lphzV1trlr9Fsq+gPXFZ8=;
        b=a9cdH+nXqA6Vt0pzd/TiTn2Xd8LP1CnbTZeFADpAXfQMYACY0Uje3Vlx/3msxCYTiV
         dq7JhWOnLN9MXuoa4/XCOwwv7a+OVjq9XNzajbx9aJob6cS87P8qiQRY8fbdP07Kmnsx
         DUHtxgR9kJaXVwpWt53dIhJ9J4zqq9rqqb4Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=QSNhk30EuwGivRxCTaGf24lphzV1trlr9Fsq+gPXFZ8=;
        b=CNqhOTver5O6Zaia8beiGPmPhQP9Qwq+OcM8Eb2S33S7SZVwdgCouZkUhL4dgzsCQc
         yjjkbCXjYB5ETr1TeegNE3Az7qL6BHC8528U+g+E5XIKLYX58wiYVUjz8CUhLN1G1/lJ
         lhNkDEQK/75KXYfkDpftduHG2Fhk9k0GIKTw883OWBv8FgXpZ4DFOtGABeTeFLvTanVh
         c9lSACfUNXZMg2ITRrwl625sD7bkrwfaC5olyP8Jcwom0NqDri9ysztBLCyTKK7La/v7
         Ph72FtjStpW9tP48/50PR1qzy/3z4qGo5w3m58ErfnKKdzZMFVWpAqbl6vXnC8uwRepw
         fTKw==
Received: by 10.49.127.115 with SMTP id nf19mr31790471qeb.36.1350353414181;
 Mon, 15 Oct 2012 19:10:14 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Mon, 15 Oct 2012 19:09:52 -0700 (PDT)
In-Reply-To: <20121015185608.GC31658@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmFNCT7896tFYuz4I5UH9A2E/bjwtqaJK49yXKg2GO3EIHjh3v6elRwkUpCqD4NnZyQHGd4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207795>

On Mon, Oct 15, 2012 at 11:56 AM, Jeff King <peff@peff.net> wrote:
> Right. The only thing that needs locking is the refs, because the object
> database is add-only for normal operations, and by definition collisions
> mean you have the same content (or are astronomically unlucky, but your
> consolation prize is that you can write a paper on how you found a sha1
> collision).

Its worth nothing that a SHA-1 collision can be identified at the
server because the server performs a byte-for-byte compare of both
copies of the object to make sure they match exactly in every way. Its
not fast, but its safe. :-)

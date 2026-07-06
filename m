Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36E3A48F6
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336013; cv=none; b=doaOHLHS8YpqBkvAq7RGIDUw+xyYkxcJAcIVtAgMbAk8VHCYvsLYn2HEFL7rCTgiV+D5pCy7OmA4mAsXQOvizye0OrjmOq2VeYclzv0ID7q+jqXHTKrdoGyLl5TwjSc2Vf0TqUTkWSed56f8iVd3XH0NxBBwQQs5KvtO9rEJ1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336013; c=relaxed/simple;
	bh=+QpeY73DApjr7eSEB77jiy0lC6SwriorF9HnCA/seVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwqNOXeNNCWbCOVvZ6OTnW05varYHMc4Gjh+DWrJUvEsmgjLGryUP+zUs+zZOgDxE4m8kEr7SxVILqoGWcFPeWfACeg2lIeQ/302ZBKYWnzMCtsvu3eaQbm5VhUdQzbtV99cb4ctsHio2PR2lRwB818PHzTnDDmCIQT9tCyzoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=epUdpuap; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="epUdpuap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783336003; x=1783940803;
	i=oswald.buddenhagen@gmx.de;
	bh=v7rzjw8TGpNTVbQI0dK4j1lJ1o6F1LntI5/SvcppBVA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=epUdpuapqFSfiw+1nX4OcITKdg5xrm7YrGBLXgZs/csQMuU5XL06b+F+au+IjDgq
	 ptOI+bROYIdhUYOolidiX5Dn+SlBw9gGs3MOxRfhkDy3adBtePGNY6fPYU/mfUoDe
	 /CaYfJspvYBf/+To41NjSynMKSwYKd4dXiyNDis6TVRJSXedslGWbdCpC5/IWMAcd
	 deVlgyIbDevZb+9biias3JPIWmH+rGJUsArrSfA3Knx5RO7VTzvVjiB4lSVS8kOU6
	 XCmGHmL/Z0QinuCttr6gbG1/eBrsLnvca60NFVh2cGIvsEZv4Ur8mgH1GFwvjMQJn
	 xEMyXN+/0FzQrDUNig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fMY-1wiM7l2xTu-004d5D; Mon, 06
 Jul 2026 13:06:43 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wgh9v-GDf-00; Mon, 06 Jul 2026 13:06:43 +0200
Date: Mon, 6 Jul 2026 13:06:43 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/11] sequencer: simplify pick_one_commit()
Message-ID: <akuMQ45aQejRcQ_Y@ugly.lan>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <f51751fa3ec1545b7304b869d91d21b055218755.1782833268.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f51751fa3ec1545b7304b869d91d21b055218755.1782833268.git.phillip.wood@dunelm.org.uk>
X-Provags-ID: V03:K1:mQBWTHsz5+bMk2ShUFyHhMXUaMFDu3tmyXShPeTFjgg5D+nvttt
 IPX0/pjwSdSMsqmWHT96lCHxA9Q6/TdDKGP9h0jxXZE5KjUtMOJGJUKfsnXV9YzSbyD88oa
 tBAI+d2d+D9/quil7VWV3Tf/hZWMT/4p6I88q1PL1zLCEPCQ9NzaBa0zj9eS2j71TdtaHcK
 w/pLQuigcHclLi2do53EA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zpLmvP/EC2c=;EGT0npsxG4Wgrf210Bt9T4SLqR5
 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
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 04:28:58PM +0100, Phillip Wood wrote:
>+++ b/sequencer.c
>@@ -4981,14 +4983,13 @@ static int pick_one_commit(struct repository *r,
> 		}
> 		return error_with_patch(r, commit,
> 					arg, item->arg_len, opts, res, !res);
>-	}
>-	if (is_rebase_i(opts) && !res)
>+	} else if (!res) {
>
because of this ...

> 		record_in_rewritten(&item->commit->object.oid,
> 				    peek_command(todo_list, 1));
>-	if (res && is_fixup(item->command)) {
>+	} else if (res && is_fixup(item->command)) {
>
.. the res conditional is pointless here.

> 		return error_failed_squash(r, item->commit, opts,
> 					   item->arg_len, arg);
>-	} else if (res && is_rebase_i(opts)) {
>+	} else if (res) {
>
and here as well.

> 		int to_amend =3D 0;
> 		struct object_id oid;
>=20

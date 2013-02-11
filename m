From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] branch: show rebase/bisect info when possible instead
 of "(no branch)"
Date: Mon, 11 Feb 2013 11:13:26 -0800
Message-ID: <7vehgmmzop.fsf@alter.siamese.dyndns.org>
References: <1359870520-22644-1-git-send-email-pclouds@gmail.com>
 <1360318171-17614-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4yp8-0000cI-RT
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 20:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758685Ab3BKTNa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2013 14:13:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758568Ab3BKTN3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2013 14:13:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF26B75A;
	Mon, 11 Feb 2013 14:13:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pTjn07dw/mGv
	Hu3RiKdYviLop9U=; b=L54Jn09Obz0IsWLdyd3XnFmn4KIEtCYj7t1nUXmjeQja
	Po68ggq6C+YMeZdgQE+AnnQ2T2kadpRfx2NX5QxGJCVglRxMGumXD7Tn+rX+SAID
	DXGHgPbXnrUniHfwsNXSqKKl19oAAWrEVf/VBhhyXox6b3THNK0wvAU8Mmn+XtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U9ypaY
	h5jN5JS30weqd0eGLsHlA9miStE7NLyhcJSWDD7IAS+26w2BYYl10jq5yImu1q7q
	huOwNTUBVLYK5JSP2EodVP1Ho74IjpcGZR0uQV6aosFqnEmLbkaUUI+QPJz/W5ly
	jqmdBXxCSkPYgzyIA/B43LtnpT/P90MeXo/mE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 719D1B759;
	Mon, 11 Feb 2013 14:13:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2413B74F; Mon, 11 Feb 2013
 14:13:27 -0500 (EST)
In-Reply-To: <1360318171-17614-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 8 Feb
 2013 17:09:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D795168-747F-11E2-BE12-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216077>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static char *get_head_description()
> +{
> +	struct stat st;
> +	struct strbuf sb =3D STRBUF_INIT;
> +	struct strbuf result =3D STRBUF_INIT;
> +	int bisect =3D 0;
> +	int ret;
> +	if (!stat(git_path("rebase-merge"), &st) && S_ISDIR(st.st_mode))
> +		ret =3D strbuf_read_file(&sb, git_path("rebase-merge/head-name"), =
0);

Hrmph.  Why isn't this checking if the file exists and then read it,
i.e.

	if (access(git_path("rebase-merge/head-name"), F_OK))
		ret =3D strbuf_read_file(&sb, git_path("rebase-merge/head-name"), 0);

It is not like you are creating this file and making sure leading
directories exist, so the sequence looks a bit strange.

> +	else if (!access(git_path("rebase-apply/rebasing"), F_OK))
> +		ret =3D strbuf_read_file(&sb, git_path("rebase-apply/head-name"), =
0);
> +	else if (!access(git_path("BISECT_LOG"), F_OK)) {
> +		ret =3D strbuf_read_file(&sb, git_path("BISECT_START"), 0);
> +		bisect =3D 1;

And if the answer to the above question is "because if rebase-merge/
exists, with or without head-name, we know we are not bisecting",
then that may suggest that the structure of if/elseif cascade is
misdesigned.  Shouldn't the "bisect" boolean be an enum "what are we
doing" that is initialized to "I do not know" and each of these
if/elseif cascade set the state to it when they know what we are
doing, in order for this function to be longer-term maintainable?

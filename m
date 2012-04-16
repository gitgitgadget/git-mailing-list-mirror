From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] tests: move code to run completion tests under
 bash into a helper library
Date: Mon, 16 Apr 2012 18:49:24 -0500
Message-ID: <20120416234923.GZ12613@burratino>
References: <20120416160124.GL5813@burratino>
 <1334614176-2963-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Apr 17 01:49:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJvfu-0003pj-TV
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 01:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883Ab2DPXte convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 19:49:34 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46622 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab2DPXte convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 19:49:34 -0400
Received: by iagz16 with SMTP id z16so8113971iag.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 16:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l+n1ewb/CKLHXuxpw0NcJ4D7w0WNfkLJkoaPKabbufU=;
        b=LGKZuUu9ekBwmX911RTrvMqcEHreI64ovHWjZbzC46HD2l4G6+x2m3Iq/F6V8ki44G
         M1qhnm2OTZW+uOKYCXZbA/pIr1G60TO6FZfFLPVUhnYXKwIZ1ftEFisl5WF5gu9hphS5
         hpGsQKBKsX5nVtMwjaQqueLJJujttGe9vQ3JbE3tgXWX7TE8ah7rNGzv3Ol3rW5NMv3q
         PDprj5dxhHfgwhM39yh01R9f+5bo4eMx6xFjkmcMPp1DhCrV3CSsUM52EVlmmnegCvBY
         29w7gyFaSUD65rS00RRiweNfjug/X1u6aA34hKqjG4+FbvWwUScR2myAXsqSMPbVYWPu
         7UMg==
Received: by 10.50.197.164 with SMTP id iv4mr7470829igc.73.1334620173513;
        Mon, 16 Apr 2012 16:49:33 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nq4sm29121893igc.5.2012.04.16.16.49.31
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 16:49:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334614176-2963-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195725>

SZEDER G=C3=A1bor wrote:

> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -3,21 +3,9 @@
>  # Copyright (c) 2012 Felipe Contreras
>  #
> =20
> -if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
> -	# we are in full-on bash mode
> -	true
> -elif type bash >/dev/null 2>&1; then
> -	# execute in full-on bash mode
> -	unset POSIXLY_CORRECT
> -	exec bash "$0" "$@"
> -else
> -	echo '1..0 #SKIP skipping bash completion tests; bash not available=
'
> -	exit 0
> -fi
> -
>  test_description=3D'test bash completion'
> =20
> -. ./test-lib.sh
> +. ./lib-completion.sh

If I understand correctly, this sources lib-completion immediately
instead of following the usual pattern of

	. ./test-lib.sh
	. "$TEST_DIRECTORY/lib-completion.sh"

to get the self-execing over with ASAP.  "$0" always refers to the
original shell script and not the file being sourced so this should be
safe.  Looks good.

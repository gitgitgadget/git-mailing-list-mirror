From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2 01/21] path.c: avoid PATH_MAX as buffer size from get_pathname()
Date: Sun, 15 Dec 2013 10:33:34 +0100
Message-ID: <CALWbr2w-ibuoV5x3GGjJ3Lazeumdj7LhvnK+zfpWvyr10nc4Fw@mail.gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
	<1387018507-21999-1-git-send-email-pclouds@gmail.com>
	<1387018507-21999-2-git-send-email-pclouds@gmail.com>
	<52AD69D4.30605@web.de>
	<CACsJy8CVQfWdTY_aoH6uMTp0cgTnvF09tC7iLD7CjEL9d9=bzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 15 10:34:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vs85K-0003nx-5X
	for gcvg-git-2@plane.gmane.org; Sun, 15 Dec 2013 10:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317Ab3LOJdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Dec 2013 04:33:42 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:58887 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab3LOJdf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Dec 2013 04:33:35 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so4270418pbc.7
        for <git@vger.kernel.org>; Sun, 15 Dec 2013 01:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fZzP1rQhruohaTqNB/DdFp+/c6N1Lo1ADfNCO6JTIn4=;
        b=J2zu/xLIbGKazkR0M+uedK+2DvLMjlznsBTp1nM3oF2iXUgKGHhl1gsKZo9FDgDTYf
         lNwvh/4+prQWNDbvrlka2lMvpzIcVOfNinYH1hmtp+UXWgTkLp29aA8JysvXz5Ecj3Sd
         alEPCw6WS0feV+dq7Hh3KGCiGvi0CETPaExuLT313GDFcjOu6bnOi9R5VEzQv+qqYmvC
         /tU3RXjacYR5YUwhcGmk2nYZ41D8N5n9AKcOCx8m3BzueenDLsjJ1VOySSGEIMs0xKDs
         9jG/Jd7dT65SpIRlBmIEt2jwwJrKdFhR8UJEgiWUwCK++4VrZDaifTN8vPpSNLeM0wxy
         i5hQ==
X-Received: by 10.68.219.72 with SMTP id pm8mr81585pbc.164.1387100014325; Sun,
 15 Dec 2013 01:33:34 -0800 (PST)
Received: by 10.70.124.228 with HTTP; Sun, 15 Dec 2013 01:33:34 -0800 (PST)
In-Reply-To: <CACsJy8CVQfWdTY_aoH6uMTp0cgTnvF09tC7iLD7CjEL9d9=bzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239326>

On Sun, Dec 15, 2013 at 10:02 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Dec 15, 2013 at 3:35 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> If we really want to go away from PATH_MAX, is a hard-coded value of=
 4096 so attractive ?
>> Because we can either
>>
>> a) Re-define PATH_MAX in git-compat-util.h
>> b) Use an own  #define in git-compat-util.h, like e.g. GIT_PATH_MAX
>> c) Change the code to use a "strbuf" which can grow on demand.
>>
>> I would prefer c) over b) over a)
>
> Looking at the code again, c) looks feasible after updating
> git_snpath() to accept a strbuf instead of buffer/size pair.

I agree that this is probably the way to go.
We are not trying to avoid PATH_MAX, but static-size array that can ove=
rflow.

Antoine,

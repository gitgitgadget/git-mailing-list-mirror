From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v6 03/19] index-helper: new daemon for caching index and
 related stuff
Date: Sun, 1 May 2016 07:22:01 +0700
Message-ID: <CACsJy8AZihi2j=LLqhPvvLm2PPR4KZne2y9ENR4YDgY+tOXo0A@mail.gmail.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
 <1461787481-877-4-git-send-email-dturner@twopensource.com>
 <xmqq60v15zmq.fsf@gitster.mtv.corp.google.com> <1461955617.4123.37.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun May 01 02:22:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awf9i-0007Mc-KI
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 02:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbcEAAWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Apr 2016 20:22:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34850 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbcEAAWc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2016 20:22:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id u64so21643293lff.2
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mZqBlxwY0meWAR7iPJYpNKCZWtoJsRX7sTHsGdrRJsA=;
        b=t5nOPIxBmZfF1gEbekQ78gxapgUrcpAxKtxmI4dv7i/8Fc9uBtb9kyty5eRoYR4yXo
         Gkp1CTOmVTwXMY9vqp+CT1ss8VYGZII+m4l9Az4EiuG1FYFTckcc+Y1V2XIT7xy920ss
         yZfrkdhs8A8frJhGQ7ZDkTtEqOk2Tm/z3r58y3NH46Vp8PouTDYN3XXYZN4azqN7cAKq
         m/ftS1cUOqeZ5F0/1nWv/2v5KxE+WFb+G0HCKU006vV6G3xfeMHrIdawha2szrHl7DWH
         kdu8Id5TeJrV9IwlkUpixoOXdiwJuPvFV9xS4SxpYTjmfYBlnR0nKeLgSAbec6Yo0ASt
         TNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mZqBlxwY0meWAR7iPJYpNKCZWtoJsRX7sTHsGdrRJsA=;
        b=UhrAwI2PnljQdqbF18q4r+/W4QhoOoCpCVN+6OziArPLVpEFV0pMXn33dpNBVj1dVb
         6SfyCh3Rc1kDUOCaJs+lLy4AyXPuzClaJBNNfBmqOF6w5F/sdMl5kfZYodyZ4oGN6Zqk
         rS/LpVaMdNUkC+bpB3L4qWftw8WubH6KjClG4tbpM/zoE7vDUIkNV0DPdv9IMx7pQb1E
         pDKN89iWnwml8wwxmwtNUu1nZWl8CtPLgoXv/ce4nwbkCoQf25W2M/qoXazuhUfiucF1
         hMx7rORF7x9U/dELP9Ilc8Hblhr8rO6l4Szpjm/VrryFdWghid5xkxVVeJMJ75On6/SN
         tMJw==
X-Gm-Message-State: AOPr4FVdLCwdVTDdPPa6Pz7nZeiLxX7ygDen6Z4gdVDm7pyU+e6XBCHyESKgdJf1SYbPrLIgcil2r9DWV1dwog==
X-Received: by 10.112.54.132 with SMTP id j4mr11741262lbp.3.1462062150929;
 Sat, 30 Apr 2016 17:22:30 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sat, 30 Apr 2016 17:22:01 -0700 (PDT)
In-Reply-To: <1461955617.4123.37.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293134>

On Sat, Apr 30, 2016 at 1:46 AM, David Turner <dturner@twopensource.com=
> wrote:
> On Thu, 2016-04-28 at 11:58 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>>
>> > From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
>> > ...
>> > The biggest gain is not having to verify the trailing SHA-1, which
>> > takes lots of time especially on large index files. But this also
>> > opens doors for further optimiztions:
>>
>> optimizAtion
>>
>> > Git can poke the daemon via unix domain sockets to tell it to
>> > refresh
>> > the index cache, or to keep it alive some more minutes. It can't
>> > give
>> > any real index data directly to the daemon. Real data goes to disk
>> > first, then the daemon reads and verifies it from there. Poking
>> > only
>> > happens for $GIT_DIR/index, not temporary index files.
>>
>> Is this limited to "poking", or the helper daemon is not involved in
>> codepaths that handle temporary index at all?  It makes sense if it
>> is the latter, and it doesn't if it were the former, but it is
>> unclear in this paragraph.
>
> It is in fact the latter.  Will clarify.

The intention is so. The execution is less than perfect. On the server
side, the index-helper only concerns itself with .git/index only.
Good. On the client side, is_main_index() is used to detect if it's
$GIT_DIR/index. It checks if the given index_state pointer points to
the_index and if so assumes that it is the main index.

That is not true when read_cache_from() is used with something other
than git_index_file() as argument. Which is exactly what
builtin/commit.c does in prepare_index(). .git/index.lock gets passed
in instead. read-cache.c may "poke" or "refresh" (probably should
rename these to "read" and "write") because is_main_index()
incorrectly returns true. Luckily it will soon find out index-helper
does not prepare shm for this particular index file and fall back to
reading from disk. We waste some context switches though.
--=20
Duy

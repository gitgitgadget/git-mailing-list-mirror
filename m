From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Make locked paths absolute when current directory is changed
Date: Mon, 21 Jul 2014 10:04:54 -0700
Message-ID: <xmqqr41ek5hl.fsf@gitster.dls.corp.google.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
	<1405858399-23082-1-git-send-email-pclouds@gmail.com>
	<1405858399-23082-2-git-send-email-pclouds@gmail.com>
	<53CD1529.9080102@ramsay1.demon.co.uk>
	<CACsJy8AXc4jvLPNpGyGdY9uzrnN-SbEeiksLDpS_=29gJ1KMnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 19:05:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9H1U-00089R-Ng
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 19:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbaGURFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2014 13:05:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50467 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932818AbaGURFD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2014 13:05:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FDFA2A52D;
	Mon, 21 Jul 2014 13:05:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1rbw5ZQhyWn+
	TxDKFhVoA4P6TlM=; b=dOhV8K0SjIo6+uWfR3iz3g/mRY6BADM3VMMZLqYOYnUh
	f5k6ZA7yxS8/f6mTiw2Oav3vNTOuRYEzwtid9nqICdBxH6u/9nF9Ytbt6ExErkEC
	w7aPZ52Qn3I0OYWaAb8JPGXPpRZcxz9jmEIs7a1h2uCGsh/ca8vr07swk3Lrcss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Y6XlVa
	JE7TxTCh3NdhT7FO+vqr/7wFpoaOz22T91ceDncNHyYtYASNZWW8n1FAXD/g9Q7t
	4B1UFgpfE8seRQTlgudOfIrV6uymmx0coqx0tyZWU8Z8rtW6KaXh1gPBIC1mDQKl
	gm4razYnjMBxXxwuANe3wR0cnVNoEe7WX7bY8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59C782A52B;
	Mon, 21 Jul 2014 13:05:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 802542A523;
	Mon, 21 Jul 2014 13:04:55 -0400 (EDT)
In-Reply-To: <CACsJy8AXc4jvLPNpGyGdY9uzrnN-SbEeiksLDpS_=29gJ1KMnQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 21 Jul 2014 20:47:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 236F4844-10F9-11E4-AE0E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253977>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jul 21, 2014 at 8:27 PM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>>> +void make_locked_paths_absolute(void)
>>> +{
>>> +     struct lock_file *lk;
>>> +     for (lk =3D lock_file_list; lk !=3D NULL; lk =3D lk->next) {
>>> +             if (lk->filename && !is_absolute_path(lk->filename)) =
{
>>> +                     char *to_free =3D lk->filename;
>>> +                     lk->filename =3D xstrdup(absolute_path(lk->fi=
lename));
>>> +                     free(to_free);
>>> +             }
>>> +     }
>>> +}
>>
>> I just have to ask, why are we putting relative pathnames in this
>> list to begin with? Why not use an absolute path when taking the
>> lock in all cases? (calling absolute_path() and using the result
>> to take the lock, storing it in the lock_file list, should not be
>> in the critical path, right? Not that I have measured it, of course!=
 :)
>
> Conservative :) I'm still scared from 044bbbc (Make git_dir a path
> relative to work_tree in setup_work_tree() - 2008-06-19). But yeah
> looking through "grep hold_" I think none of the locks is in critical
> path. absolute_path() can die() if cwd is longer than PATH_MAX (and
> doing this reduces the chances of that happening). But Ren=C3=A9 is a=
dding
> strbuf_getcwd() that can remove that PATH_MAX. So I guess we should b=
e
> fine with putting absolute_path() in hold_lock_file_...*

OK, we should center these efforts around the strbuf_getcwd() topic,
basing the other topic on realpath() and this one on it then?

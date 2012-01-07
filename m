From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3] Limit refs to fetch to minimum in shallow clones
Date: Sat, 7 Jan 2012 21:16:22 +0700
Message-ID: <CACsJy8DrabLzoxpmQqU13-81k=7Ni8kbg4HX3V67e3AL=L39wQ@mail.gmail.com>
References: <1325743516-14940-1-git-send-email-pclouds@gmail.com>
 <1325833869-20078-1-git-send-email-pclouds@gmail.com> <7vfwfsllny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 15:17:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjX4x-0006wR-PU
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 15:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974Ab2AGOQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jan 2012 09:16:57 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41806 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab2AGOQz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2012 09:16:55 -0500
Received: by bkcjm19 with SMTP id jm19so624260bkc.19
        for <git@vger.kernel.org>; Sat, 07 Jan 2012 06:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9SWurx3jGz7rJ7bajt1MTPToUbcVi+TLwDmdWr6OsM8=;
        b=i48Iqr3cys5MwQazCY+gkVEp3dlDoc4eBCsy/SJQdVjoBerxs8sFyGbU8yfMZyDm0G
         dueSgJ450J8jfg6ifg/fQ+WxTABaJs53LKYCRTNfZ200xmqblS07ktn5CMltYj882rbD
         fpOwcWAZ0WfwuWrNQkkeKNjY8aR5OR3eY6OnY=
Received: by 10.204.156.156 with SMTP id x28mr4316714bkw.76.1325945814147;
 Sat, 07 Jan 2012 06:16:54 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Sat, 7 Jan 2012 06:16:22 -0800 (PST)
In-Reply-To: <7vfwfsllny.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188078>

2012/1/7 Junio C Hamano <gitster@pobox.com>:
> My first reaction after reading "is implied by default" was "Huh? did=
n't
> we just read these kick in only when --depth is given?" and I had to =
read
> it again. Here is my attempt to rephrase it.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Clone only the history leading to the tip =
of a single branch,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0either specified by the `--branch` option =
or the primary branch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remote's `HEAD` points at. When creating a=
 shallow clone with the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0`--depth` option, this is the default, unl=
ess `--no-single-branch`
> =C2=A0 =C2=A0 =C2=A0 =C2=A0is given to fetch the histories near the t=
ips of all branches.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Currently this option only works when crea=
ting a shallow clone and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0does not have any effect without the `--de=
pth` option.
>
> We might want to later enhance this to work also with a full-depth cl=
one
> that tracks only one branch, and the above phrasing would make it cle=
ar.

Interesting. Yes that's another possibility.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!option_branch)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 remote_head =3D guess_remote_head(head, refs, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 struct strbuf sb =3D STRBUF_INIT;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strbuf_addstr(&sb, src_ref_prefix);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strbuf_addstr(&sb, option_branch);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 remote_head =3D find_ref_by_name(refs, sb.buf);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strbuf_release(&sb);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!remote_head)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die(_("Remote branch \"%s\" not found. Nothing to clone.\n"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 "Try --no-single-branch to fetch all refs."),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 option_branch ? option_branch : "HEAD");
>
> Switching upon option_branch to tweak the message is a good idea, but
> strictly speaking, we would hit this die() when guess_remote_head() d=
oes
> not find where HEAD points at because it is detached, and in that cas=
e,
> the error is not "Nothing to clone", but "We couldn't tell which bran=
ch
> you meant to limit this cloning to".

Yeah. And in detached case without --branch, we probably should not
say anything.

>> @@ -642,9 +679,12 @@ int cmd_clone(int argc, const char **argv, cons=
t char *prefix)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transport_set_optio=
n(transport, TRANS_OPT_KEEP, "yes");
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (option_depth)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (option_depth) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 transport_set_option(transport, TRANS_OPT_DEPTH,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0option_depth);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 transport_set_option(transport, TRANS_OPT_FOLLOWTAGS,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0option_single_branch ? "1" : NULL);
>
> Curious. Does anybody set FOLLOWTAGS to the transport by default beco=
re we
> come here (just asking)?

No, I just hate another "if (option_single_branch)", which indents the
call one more time. Always setting it to "1" in this case should
probably be OK too. I'm just not sure if upload-pack realizes all tags
are requested so include-tag extension means nothing, or it does extra
work for no gain.
--=20
Duy

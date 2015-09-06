From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] am: match --signoff to the original scripted version
Date: Sun, 6 Sep 2015 17:04:13 +0800
Message-ID: <CACRoPnTUzeF=RUVv_0+2Ej422Vh-NH+KpYaKH0VKNmGbuVQ_8g@mail.gmail.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 11:04:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYVsN-0002sK-79
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 11:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbbIFJES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 05:04:18 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34603 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbbIFJEP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 05:04:15 -0400
Received: by lbbmp1 with SMTP id mp1so27444513lbb.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DbeXH4K6xYGKE09tjtVLOpQbiAu4EZ+qbMRXIlSFovk=;
        b=DQmGDz6et7caBya8YGSSyIEN385HTzRrCOgRZY+qULs5hoxiLarHK72YOEYB3J2iL8
         cwC6VrQbd3QKbPaqiGLNUL0AGvMICHCT2vl+/hSYU9QMfOOg0i7qC7GMBfrpI2M14nBq
         wwO0pLgb/aUmBPgdxUrbl3WxLTMdJ9oE77w/AVpcq256mua3lDBzzsQ/V2KpGwesnDXY
         /L2UjXA320bjHVtG0dZdwaNsh1L5TDV3MAHbO5uiYcG0UTahncsO8dOTKofJc3tlVLCL
         HLPRYECKSdqtz5dJcVMCTQMMF+X61VMxyK9EQv0O+BV0OKpiiZova9YCxTJtCNtLV63f
         93wg==
X-Received: by 10.152.5.68 with SMTP id q4mr11908929laq.66.1441530253222; Sun,
 06 Sep 2015 02:04:13 -0700 (PDT)
Received: by 10.112.62.196 with HTTP; Sun, 6 Sep 2015 02:04:13 -0700 (PDT)
In-Reply-To: <xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277418>

Hi,

Thanks for handling this.

On Sun, Sep 6, 2015 at 12:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus noticed that the recently reimplementated "git am -s" defines

s/reimplementated/reimplemented/ ?

> the trailer block too rigidly, resulting an unnecessary blank line

s/resulting an/resulting in an/ ?

> between the existing sign-offs and his new sign-off.  An e-mail
> submission sent to Linus in real life ends with mixture of sign-offs
> and commentaries, e.g.
>
>         title here
>
>         message here
>
>         Signed-off-by: Original Author <original@auth.or>
>         [rv: tweaked frotz and nitfol]
>         Signed-off-by: Re Viewer <rv@ew.er>
>         Signed-off-by: Other Reviewer <other@rev.ewer>
>         ---
>         patch here
>
> Because the reimplementation reused append_signoff() helper that is
> used by other codepaths, which is unaware that people intermix such
> comments with their sign-offs in the trailer block, such a message
> was judged to end with a non-trailer, resulting in an extra blank

s/extra blank/extra blank line/ ?

> before adding a new sign-off.
>
> The original scripted version of "git am" used a lot looser
> definition, i.e. "if and only if there is no line that begins with
> Signed-off-by:, add a blank line before adding a new sign-off".  For
> the upcoming release, stop using the append_signoff() in "git am"
> and reimplement the looser definition used by the scripted version
> to use only in "git am" to fix this regression in "am" while
> avoiding new regressions to other users of append_signoff().
>
> In the longer term, we should look into loosening append_signoff()
> so that other codepaths that add a new sign-off behave the same way
> as "git am -s", but that is a task for post-release.
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/am.c  | 31 +++++++++++++++++++++++++++++--
>  t/t4150-am.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 634f7a7..e7828e5 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1191,6 +1191,33 @@ static void NORETURN die_user_resolve(const struct am_state *state)
>         exit(128);
>  }
>
> +static void am_signoff(struct strbuf *sb)
> +{

Hmm, okay, but now we have two similarly named functions am_signoff()
and am_append_signoff() which both do nearly similar things, the only
difference being am_signoff() operates on a strbuf while
am_append_signoff() operates on the "msg" char* field in the am_state,
which seems a bit iffy to me. I wonder if the logic could be
implemented in am_append_signoff() instead so we have only one
function?

> +       char *cp;
> +       struct strbuf mine = STRBUF_INIT;
> +
> +       /* Does it end with our own sign-off? */
> +       strbuf_addf(&mine, "\n%s%s\n",
> +                   sign_off_header,
> +                   fmt_name(getenv("GIT_COMMITTER_NAME"),
> +                            getenv("GIT_COMMITTER_EMAIL")));

Maybe use git_committer_info() here?

> +       if (mine.len < sb->len &&
> +           !strcmp(mine.buf, sb->buf + sb->len - mine.len))

Perhaps use ends_with()?

> +               goto exit; /* no need to duplicate */
> +
> +       /* Does it have any Signed-off-by: in the text */
> +       for (cp = sb->buf;
> +            cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
> +            cp = strchr(cp, '\n')) {
> +               if (sb->buf == cp || cp[-1] == '\n')
> +                       break;
> +       }
> +
> +       strbuf_addstr(sb, mine.buf + !!cp);
> +exit:
> +       strbuf_release(&mine);
> +}
> +
>  /**
>   * Appends signoff to the "msg" field of the am_state.
>   */
> @@ -1199,7 +1226,7 @@ static void am_append_signoff(struct am_state *state)
>         struct strbuf sb = STRBUF_INIT;
>
>         strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
> -       append_signoff(&sb, 0, 0);
> +       am_signoff(&sb);
>         state->msg = strbuf_detach(&sb, &state->msg_len);
>  }
>
> @@ -1303,7 +1330,7 @@ static int parse_mail(struct am_state *state, const char *mail)
>         stripspace(&msg, 0);
>
>         if (state->signoff)
> -               append_signoff(&msg, 0, 0);
> +               am_signoff(&msg);
>
>         assert(!state->author_name);
>         state->author_name = strbuf_detach(&author_name, NULL);

Thanks again,
Paul

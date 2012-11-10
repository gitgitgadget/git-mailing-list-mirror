From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Sat, 10 Nov 2012 20:00:28 -0000
Organization: OPDS
Message-ID: <03ED9D50D1F64467863C051959CFC433@PhilipOakley>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1; reply-type=original
Cc: "Git List" <git@vger.kernel.org>
To: "Jean-Jacques Lafay" <jeanjacques.lafay@gmail.com>,
	<msysgit@googlegroups.com>
X-From: msysgit+bncBDSOTWHYX4PBBQ7E7KCAKGQEIXGUPHA@googlegroups.com Sat Nov 10 21:00:14 2012
Return-path: <msysgit+bncBDSOTWHYX4PBBQ7E7KCAKGQEIXGUPHA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBQ7E7KCAKGQEIXGUPHA@googlegroups.com>)
	id 1TXHDy-0003M1-D8
	for gcvm-msysgit@m.gmane.org; Sat, 10 Nov 2012 21:00:14 +0100
Received: by mail-lb0-f186.google.com with SMTP id y2sf183012lbk.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 10 Nov 2012 12:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-ironport-anti-spam-filtered
         :x-ironport-anti-spam-result:x-ironport-av:message-id:reply-to:from
         :to:cc:references:subject:date:organization:mime-version:x-priority
         :x-msmail-priority:x-mailer:x-mimeole:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=tdBH7D+6MKik2HVAhykOuwG/57juoOPBGD2lm1RTS58=;
        b=TXnkICCgoCN2Qb0a4fOcNMLMw7vyTY/QNImbf3h/5rzB9xZTteoDDwCyytucpMCFt3
         v/K2n4fzC4JBK8ZB9gmOUR3+GPAo4dRDHigWkFULzifjSTVa6q30FwJYFplZiC3c9fwe
         Cu0eSK/DCBzImM5EzKLsqc3ohL3NwDTfIecBESQynxGHImCMABOb2/xTQesqvwYuN8/8
         BwYNcXLkC0cFtw8CfzR0hxy 
Received: by 10.216.150.201 with SMTP id z51mr442488wej.30.1352577604787;
        Sat, 10 Nov 2012 12:00:04 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.53.65 with SMTP id f43ls1978216wec.1.gmail; Sat, 10 Nov
 2012 12:00:03 -0800 (PST)
Received: by 10.180.95.227 with SMTP id dn3mr1307162wib.1.1352577603183;
        Sat, 10 Nov 2012 12:00:03 -0800 (PST)
Received: by 10.180.95.227 with SMTP id dn3mr1307161wib.1.1352577603167;
        Sat, 10 Nov 2012 12:00:03 -0800 (PST)
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net. [62.24.128.238])
        by gmr-mx.google.com with ESMTP id z7si349613wiw.1.2012.11.10.12.00.03;
        Sat, 10 Nov 2012 12:00:03 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.238 as permitted sender) client-ip=62.24.128.238;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqwNAPmxnlBcHm+W/2dsb2JhbABEi1i2eQEBAoEAgQmCGQUBAQUIAQEdER4BASELAgMFAgEDFQELJRQBBAgSBgcXBgESCAIBAgMBh2cDE7IuDYlUiyxpUDEcNYQXYQOIJYVPhjONB4URgm8
X-IronPort-AV: E=Sophos;i="4.80,753,1344207600"; 
   d="scan'208";a="409124127"
Received: from host-92-30-111-150.as13285.net (HELO PhilipOakley) ([92.30.111.150])
  by out1.ip02ir2.opaltelecom.net with SMTP; 10 Nov 2012 20:00:02 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.238 as permitted sender) smtp.mail=philipoakley@iee.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209303>

From: "Jean-Jacques Lafay" <jeanjacques.lafay@gmail.com> Sent: Saturday, 
November 10, 2012 5:36 PM
> In large repos, the recursion implementation of contains(commit, 
> commit_list)
> may result in a stack overflow. Replace the recursion with a loop to 
> fix it.
>
> Signed-off-by: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>

This is a change to the main git code so it is better to submit it to 
the main git list at git@vger.kernel.org (plain text, no HTML, first 
post usually has a delay ;-)

It sounds reasonable but others may have opinions and comments.

Have you actually suffered from the stack overflow issue? You only 
suggest it as a possibility, rather than a real problem.

Philip

> ---
> builtin/tag.c  | 83 
> ++++++++++++++++++++++++++++++++++++++++------------------
> t/t7004-tag.sh | 21 +++++++++++++++
> 2 files changed, 78 insertions(+), 26 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 9c3e067..4be67dd 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -73,40 +73,71 @@ static int in_commit_list(const struct commit_list 
> *want, struct commit *c)
>  return 0;
> }
>
> -static int contains_recurse(struct commit *candidate,
> -     const struct commit_list *want)
> -{
> - struct commit_list *p;
> -
> - /* was it previously marked as containing a want commit? */
> - if (candidate->object.flags & TMP_MARK)
> - return 1;
> - /* or marked as not possibly containing a want commit? */
> - if (candidate->object.flags & UNINTERESTING)
> - return 0;
> - /* or are we it? */
> - if (in_commit_list(want, candidate))
> - return 1;
> +struct commit_list_list {
> + struct commit *item;
> + struct commit_list *next_item;
> + struct commit_list_list *next;
> +};
>
> - if (parse_commit(candidate) < 0)
> - return 0;
> +static void mark_path(struct commit_list_list *path, int status)
> +{
> + struct commit_list_list *temp;
> + while (path) {
> + path->item->object.flags |= status;
> + temp = path;
> + path = temp->next;
> + free(temp);
> + }
> +}
>
> - /* Otherwise recurse and mark ourselves for future traversals. */
> - for (p = candidate->parents; p; p = p->next) {
> - if (contains_recurse(p->item, want)) {
> - candidate->object.flags |= TMP_MARK;
> +static int contains(struct commit *candidate,
> +     const struct commit_list *want)
> +{
> + /* previously implemented with a recursion, but could stack overflow 
> in large repos */
> + struct commit_list_list *p, *tmp;
> + p = xmalloc(sizeof(struct commit_list_list));
> + p->item = candidate;
> + p->next_item = NULL;
> + p->next = NULL;
> +
> + while (p) {
> + candidate = p->item;
> +
> + /* is it ok : */
> + /* was it previously marked as containing a want commit? */
> + /* or are we it? */
> + if (candidate->object.flags & TMP_MARK || in_commit_list(want, 
> candidate)) {
> + mark_path(p, TMP_MARK);
>  return 1;
>  }
> + /* is it not ok : */
> + /* was it previously marked as not possibly containing a want 
> commit? */
> + /* do we have parents? */
> + if (candidate->object.flags & UNINTERESTING || 
> parse_commit(candidate) < 0 || !candidate->parents) {
> + candidate->object.flags |= UNINTERESTING;
> + /* then backtrack, marking as UNINTERESTING along the way */
> + while (p && !p->next_item) {
> + p->item->object.flags |= UNINTERESTING;
> + tmp = p;
> + p = tmp->next;
> + free(tmp);
> + }
> + if (p) {
> + p->item = p->next_item->item;
> + p->next_item = p->next_item->next;
> + }
> + } else {
> + /* let's check the parents */
> + tmp = xmalloc(sizeof(struct commit_list_list));
> + tmp->item = candidate->parents->item;
> + tmp->next_item = candidate->parents->next;
> + tmp->next = p;
> + p = tmp;
> + }
>  }
> - candidate->object.flags |= UNINTERESTING;
>  return 0;
> }
>
> -static int contains(struct commit *candidate, const struct 
> commit_list *want)
> -{
> - return contains_recurse(candidate, want);
> -}
> -
> static void show_tag_lines(const unsigned char *sha1, int lines)
> {
>  int i;
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 5189446..196ac54 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1365,4 +1365,25 @@ test_expect_success 'multiple --points-at are 
> OR-ed together' '
>  test_cmp expect actual
> '
>
> +# what about a deep repo ?
> +
> +>expect
> +test_expect_success '--contains works in a deep repo' '
> + i=1
> + while test $i -lt 40000
> + do
> + echo "commit refs/heads/master
> +committer A U Thor <author@example.com> $((1000000000 + $i * 100)) 
> +0200
> +data <<EOF
> +commit #$i
> +EOF"
> + test $i == 1 && echo "from refs/heads/master^0"
> + i=$(($i + 1))
> + done | git fast-import
> + git checkout master
> + git tag far-far-away HEAD^
> + git tag --contains HEAD >actual &&
> + test_cmp expect actual
> +'
> +
> test_done
> -- 
> 1.8.0.msysgit.0.1.geed93bd.dirty
>
> -- 

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

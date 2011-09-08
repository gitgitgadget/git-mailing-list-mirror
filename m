From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 5/2] push -s: receiving end
Date: Thu, 8 Sep 2011 11:31:58 +0200
Message-ID: <201109081131.58362.johan@herland.net>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org> <7vehzrzm0e.fsf@alter.siamese.dyndns.org> <7v7h5jzj8o.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 11:32:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1ay3-0008BF-E0
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 11:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542Ab1IHJcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 05:32:13 -0400
Received: from smtp.opera.com ([213.236.208.81]:52662 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932493Ab1IHJcM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 05:32:12 -0400
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p889VwaD009120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 8 Sep 2011 09:31:59 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-Reply-To: <7v7h5jzj8o.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180959>

On Thursday 8. September 2011, Junio C Hamano wrote:
> This stores the GPG signed push certificate in the receiving
> repository using the notes mechanism. The certificate is appended to
> a note in the refs/notes/signed-push tree for each object that
> appears on the right hand side of the push certificate, i.e. the
> object that was pushed to update the tip of a ref.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

(...)

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 307fc3b..257f2a5 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -156,6 +161,7 @@ struct command {
>  };
> 
>  static const char pre_receive_hook[] = "hooks/pre-receive";
> +static const char pre_receive_signature_hook[] =
> "hooks/pre-receive-signature"; static const char post_receive_hook[]
> = "hooks/post-receive";
> 
>  static void rp_error(const char *err, ...) __attribute__((format
> (printf, 1, 2))); @@ -581,6 +587,22 @@ static void
> check_aliased_updates(struct command *commands)
> string_list_clear(&ref_list, 0);
>  }
> 
> +static void get_note_text(struct strbuf *buf, struct notes_tree *t,
> +			  const unsigned char *object)
> +{
> +	const unsigned char *sha1 = get_note(t, object);
> +	char *text;
> +	unsigned long len;
> +	enum object_type type;
> +
> +	if (!sha1)
> +		return;
> +	text = read_sha1_file(sha1, &type, &len);
> +	if (text && len && type == OBJ_BLOB)
> +		strbuf_add(buf, text, len);
> +	free(text);
> +}
> +

What about adding this function to notes.h as a convenience to other 
users of the notes API?

Otherwise the code looks good to me.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

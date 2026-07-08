Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FB442CAE4
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507452; cv=none; b=LQxXeicHHu2jFAo3W1EVoSdC1oO/GT+JOclYrIABEVdk0q5a8gilKvSxREdJ4e7HmmkKGGaVRzJJyosJMIxcb2TfYPNs64mORB3R0VZLVa/PWwHYacdz6HU70/Akcnoj7wsGRiVEcQlO9uJQ0II4LMZeBY/z5IYkjXEKfB9YsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507452; c=relaxed/simple;
	bh=H8FUdjnSSazxz0FAXu2Z3IrA1aDo40guOvL28F5t+s0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nkls6Gp2fDGOjDZlty2ExlBGokKqZE60PcKU0QKjdhhBGDb2TWJcUgiDYMl711/MkFXuz28sPbu1ZFTTlx5mmnjBrLgBFcNSOIBRwi/m4/wR+WhGrNw+hMqhUkQcLyPYgUkMa5iwPme+Zd1mD16xN1jYyMuKhwR6dWC3TMei+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=W82iZCbl; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="W82iZCbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783507433; x=1784112233; i=l.s.r@web.de;
	bh=Apx5P76wtVwlmcU3AAGRngHMuLceFduiWdu2+sf1SSg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W82iZCbl8ZIk5lLnHWIAoDh1SY7YoHbQo1Konl1C8sm8PiT3WFSlehVMqahTOj2C
	 nl3asFlr/gCuunCAMpJ+5cmJ48wMEkDHzKyduz28b2Euj71cNg/5+t0x37HpeWjMl
	 MgHcLsSN3rS0vtnbp2rz9i93leipGrhGWTzt0czWwCt/PgwU2qDrjGeOLe4RDnD3t
	 nsLBoYwS4b0jTM5tsuzvWskQqLsx8fC4s3L7ejTptY0VQwstWkvOeVVUkbx2fEcSF
	 P+OpjdpADIKWf9nK6gzoM4EyDQ1t/DMU15jwkakeeIy2FMnyIhWX//am2985CcW4D
	 Oy+8P8wBYOcW7rlzSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8n08-1xAl0Y3N70-014ax3; Wed, 08
 Jul 2026 12:43:52 +0200
Message-ID: <57bb0e9e-221d-4234-b5bc-a87610e8263c@web.de>
Date: Wed, 8 Jul 2026 12:43:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v2] prio-queue: use cascade-down for faster extract-min
To: Kristofer Karlsson <krka@spotify.com>, Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
 <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
 <90270818-c52b-4611-8da2-6cee20628fc2@web.de>
 <CAL71e4Ob-B5MJ5DPY+_tzpj6nyrbQ5WutxED2T93SWJV6kJGPA@mail.gmail.com>
 <CAL71e4PV-1aDvn1JnweMa3OR1xxB75fWjzJOBvM54KOWqC0stw@mail.gmail.com>
 <1aa5b755-0f74-46d5-bd6e-a9cb7f3fbb12@web.de>
 <CAL71e4NZYdpw5cvi6ARn1req8xaRGGg9X4xhZKp6S9Dz4K23aQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAL71e4NZYdpw5cvi6ARn1req8xaRGGg9X4xhZKp6S9Dz4K23aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8ltyp8Lf0dTWYpzkO/k3U+XnSDhATQC43xP22tK33Cc2SNqu9Tr
 zHYMQURhn7h3iM+dhpTMYEi0bmr8szL0dgmEtFu9/YDzDEBbUneKDbSUcnUYoYc+4RWG0ib
 Bkp7q6/t3XiRDCmdultD4SsK57+Q5gG1QqrNuuXtVwuK8jcJp4nC0VYA+WqMSKlZOK3yocF
 i6qdVqtQGdQh/0rJ5zZKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DKi/bCA9u+8=;854Zdcs7kLQMYXrLx/IErAVI27k
 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
 bbuyK82AA=

On 7/6/26 11:52 PM, Kristofer Karlsson wrote:
> On Sun, 7 Jun 2026 at 09:30, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> So I guess we keep the full sift-down for prio_queue_replace(), knowing
>> that sometimes we have a lot of items that end up at or close to the
>> root of the heap.
>=20
> The lazy-fold series (kk/prio-queue-get-put-fusion) is in next now.
> I rebased this cascade patch on top of it to check if it's still
> useful.
>=20
> With lazy-fold in place the regression scenario you identified
> is resolved. The only remaining change is in flush_get(),
> where unfused gets now cascade instead of sifting down:
>=20
>   -    queue->array[0] =3D queue->array[--queue->nr_];
>   -    sift_down_root(queue);
>   +    --queue->nr_;
>   +    sift_up_rebalance(queue);
>=20
> plus the ~20-line sift_up_rebalance() implementation.
>=20
> I benchmarked this on the linux kernel repo and on a large
> merge-heavy repo.
>=20
> The results are consistent: a real but small 1-2% end-to-end
> improvement across commands. A prio-queue microbenchmark
> would likely show a larger difference, but the queue
> is only a fraction of the total work in any real git operation.
>=20
> The lazy-fold optimization cannibalized some of the value here,
> so cascade only helps the remaining unfused gets. As you observed,
> cascade is better there, but there are fewer of them now that there
> is more fusing happening.
>=20
> I am on the fence about whether 1-2% end-to-end justifies adding
> another sift function. If you (Ren=C3=A9 and Junio) think the benefit
> is too small for the code cost, I am happy to drop this patch.
> Otherwise I can submit a small reroll on top of
> kk/prio-queue-get-put-fusion (or rather next, in practice).

tl;dr: Yes, please, but I'm biased.

The text size of prio-queue.o on Apple silicon increases from 1351 to
1563 bytes for me, 212 bytes or 16% more.  OK.

It makes intuitive sense to find the new position of the last item by
searching from the bottom up instead of from the top down.  Timings
confirm it.  Are there pathologic cases that perform worse, though?  I
don't see how to construct one.  It would require an unbalanced heap,
where the bottom items from one branch would rise high in other
branches.  Is this even possible?

For a full drain (only _get(), no _put()) of up to 12 items the answer
is no, at least.  Cascade never needs more comparisons for any
permutation; test code below.  Here are the aggregate numbers:

       next           cascade
    n  min max  mean  min max  mean
    2    0   0   0.0    0   0   0.0
    3    1   1   1.0    1   1   1.0
    4    3   3   3.0    3   3   3.0
    5    5   6   5.8    5   6   5.6
    6    7  10   8.7    7   9   8.0
    7   10  14  12.0    9  12  10.9
    8   14  18  16.3   12  16  13.9
    9   18  23  20.9   15  20  17.4
   10   22  29  25.5   18  24  20.7
   11   26  35  30.5   21  28  24.4
   12   30  41  35.5   24  33  27.9

sift_up_rebalance() is a combination of sift_down_root() with an empty
root and the bubble-up operation from prio_queue_put().  The latter can
easily be factored out into a sift-up function, reducing code
duplication.

Extending sift_down_root() to deal with an empty root would be easy as
well, but also a bit tricky to avoid pointless checks for each caller.
Not sure it's worth it.  Like this perhaps?

static inline size_t sift_down_root(struct prio_queue *queue, bool empty)
{
        size_t ix, child;

        /* Push down the one at the root */
        for (ix =3D 0; ix * 2 + 1 < queue->nr_; ix =3D child) {
                child =3D ix * 2 + 1; /* left */
                if (child + 1 < queue->nr_ &&
                    compare(queue, child, child + 1) >=3D 0)
                        child++; /* use right child */

                if (empty)
                        queue->array[ix] =3D queue->array[child];
                else if (compare(queue, ix, child) <=3D 0)
                        break;
                else
                        swap(queue, child, ix);
        }
        return ix;
}

Anyway, my point is that it's not "adding another sift function", but
remixing existing ones, which I only count as half. :)

I'd very much like to see this go in because it seems to be strictly
faster, makes intuitive sense and adds only little code.   I didn't
find this method used anywhere else, which is a warning sign, but I
can't find any catch.

Ren=C3=A9


  $ for n in $(seq 2 2)
    do
        t/helper/test-tool prio-queue permute get $n |
        awk -v n=3D$n -v max=3D0 '
            {sum+=3D$2}
            max < $2 {max=3D$2}
            !min || min > $2 {min=3D$2}
            END {printf "%2d %3d %3d %5.1f \n", n, min, max, sum/NR}
        '
    done

=2D--
 Makefile                   |  1 +
 t/helper/test-prio-queue.c | 91 +++++++++++++++++++++++++++++++++++++++++=
+++++
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 4 files changed, 94 insertions(+)

diff --git a/Makefile b/Makefile
index 1f3f099f5c5..ba7d293cf5f 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -843,6 +843,7 @@ TEST_BUILTINS_OBJS +=3D test-partial-clone.o
 TEST_BUILTINS_OBJS +=3D test-path-utils.o
 TEST_BUILTINS_OBJS +=3D test-path-walk.o
 TEST_BUILTINS_OBJS +=3D test-pcre2-config.o
+TEST_BUILTINS_OBJS +=3D test-prio-queue.o
 TEST_BUILTINS_OBJS +=3D test-pkt-line.o
 TEST_BUILTINS_OBJS +=3D test-proc-receive.o
 TEST_BUILTINS_OBJS +=3D test-progress.o
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
new file mode 100644
index 00000000000..c175021b12b
=2D-- /dev/null
+++ b/t/helper/test-prio-queue.c
@@ -0,0 +1,91 @@
+#include "test-tool.h"
+#include "prio-queue.h"
+
+/* Generate all permutations using Heap's algorithm. */
+static int permute_ints(size_t n, void (*fn)(int *, size_t))
+{
+	int *arr;
+	size_t *c;
+
+	ALLOC_ARRAY(arr, n);
+	for (size_t i =3D 0; i < n; i++)
+		arr[i] =3D i + 1;
+	CALLOC_ARRAY(c, n);
+
+	fn(arr, n);
+	for (size_t i =3D 1; i < n; i++) {
+		if (c[i] < i) {
+			SWAP(arr[i & 1 ? c[i] : 0], arr[i]);
+			fn(arr, n);
+			c[i]++;
+			i =3D 0;
+		} else {
+			c[i] =3D 0;
+		}
+	}
+
+	free(arr);
+	free(c);
+
+	return 0;
+}
+
+static uintmax_t nr_of_compares;
+
+static int compare_ints(const void *a_, const void *b_, void *cb_data UNU=
SED)
+{
+	const int *a =3D a_;
+	const int *b =3D b_;
+	nr_of_compares++;
+	return *a - *b;
+}
+
+static void report(const char *name, const int *arr, size_t n)
+{
+	printf("%s %"PRIuMAX" for", name, nr_of_compares);
+	for (size_t i =3D 0; i < n; i++)
+		printf(" %d", arr[i]);
+	putchar('\n');
+}
+
+static void get_permutation(int *arr, size_t n)
+{
+	static struct prio_queue queue =3D { compare_ints };
+
+	for (size_t i =3D 0; i < n; i++)
+		prio_queue_put(&queue, &arr[i]);
+
+	nr_of_compares =3D 0;
+	for (size_t i =3D 0; i < n; i++)
+		prio_queue_get(&queue);
+
+	report("get", arr, n);
+}
+
+static void put_permutation(int *arr, size_t n)
+{
+	struct prio_queue queue =3D { compare_ints };
+
+	nr_of_compares =3D 0;
+	for (size_t i =3D 0; i < n; i++)
+		prio_queue_put(&queue, &arr[i]);
+
+	report("put", arr, n);
+
+	clear_prio_queue(&queue);
+}
+
+int cmd__prio_queue(int argc, const char **argv)
+{
+	if (argc =3D=3D 4 && !strcmp(argv[1], "permute")) {
+		size_t n =3D strtoul(argv[3], NULL, 10);
+		if (!strcmp(argv[2], "get"))
+			return permute_ints(n, get_permutation);
+		if (!strcmp(argv[2], "put"))
+			return permute_ints(n, put_permutation);
+	}
+
+	fprintf(stderr, "usage: test-tool prio-queue permute get <n>\n");
+	fprintf(stderr, "   or: test-tool prio-queue permute put <n>\n");
+	return 129;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43bb..69352f541f4 100644
=2D-- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -57,6 +57,7 @@ static struct test_cmd cmds[] =3D {
 	{ "path-walk", cmd__path_walk },
 	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
+	{ "prio-queue", cmd__prio_queue },
 	{ "proc-receive", cmd__proc_receive },
 	{ "progress", cmd__progress },
 	{ "reach", cmd__reach },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d58..ab0d3e01d1e 100644
=2D-- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -50,6 +50,7 @@ int cmd__path_utils(int argc, const char **argv);
 int cmd__path_walk(int argc, const char **argv);
 int cmd__pcre2_config(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
+int cmd__prio_queue(int argc, const char **argv);
 int cmd__proc_receive(int argc, const char **argv);
 int cmd__progress(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);

